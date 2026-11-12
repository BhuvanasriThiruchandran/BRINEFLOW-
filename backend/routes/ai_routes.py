import os

from flask import Blueprint, request, jsonify, current_app
from google import genai

from services.sensor_service import SensorService

bp = Blueprint("ai", __name__, url_prefix="/api")

# Get Gemini API key from .env
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")

if not GEMINI_API_KEY:
    raise RuntimeError("GEMINI_API_KEY is not configured")

# Create Gemini client
client = genai.Client(api_key=GEMINI_API_KEY)


def _generate_ai_reply(prompt: str, user_message: str, sensor_data: dict) -> str:
    """Generate a reply using Gemini when available, else use a local fallback."""
    for model_name in (
        "gemini-3.8-flash",
        "gemini-3.5-flash-lite",
        "gemini-3.5-flash",
        "gemini-2.5-flash",
    ):
        try:
            response = client.models.generate_content(
                model=model_name,
                contents=prompt,
            )
            reply = getattr(response, "text", "")
            if reply and reply.strip():
                return reply.strip()
        except Exception as exc:
            current_app.logger.warning(
                "Gemini generation failed for model %s: %s",
                model_name,
                exc,
            )
            error = str(exc).upper()
            if any(
                marker in error
                for marker in (
                    "404",
                    "NOT_FOUND",
                    "429",
                    "RESOURCE_EXHAUSTED",
                    "500",
                    "INTERNAL",
                    "503",
                    "UNAVAILABLE",
                    "TIMEOUT",
                    "CONNECTION",
                )
            ):
                continue
            break

    return _build_fallback_reply(user_message, sensor_data)


def _build_fallback_reply(user_message: str, sensor_data: dict) -> str:
    """Provide a transparent, data-grounded reply when Gemini is unavailable."""
    question = user_message.lower()
    readings_available = bool(sensor_data.get("timestamp"))

    if "brineflow" in question:
        return (
            "BrineFlow is a solar saltpan management system that helps monitor pond "
            "conditions, track sensor health, and support better salt production decisions."
        )

    if "yield" in question or "profit" in question or "harvest" in question:
        return (
            "I can't provide a reliable yield, profit, or harvest estimate while the AI service is unavailable. "
            "The sensor readings alone are not a validated production forecast; please use a verified prediction "
            "from the dashboard rather than relying on a guessed estimate."
        )

    metric = None
    if "salinity" in question:
        metric = ("salinity", "ppt")
    elif "temperature" in question:
        metric = ("temperature", "°C")
    elif "humidity" in question:
        metric = ("humidity", "%")
    elif "water level" in question or "water_level" in question or "water-level" in question:
        metric = ("water_level", "%")

    if metric:
        name, unit = metric
        if not readings_available:
            return (
                f"I couldn't retrieve the latest {name.replace('_', ' ')} reading, so I can't give you a "
                "reliable current value. Please check the dashboard's latest sensor reading."
            )
        return f"The latest {name.replace('_', ' ')} reading available to me is {sensor_data[name]} {unit}."

    if "pond" in question and ("attention" in question or "condition" in question):
        if not readings_available:
            return (
                "I can't reliably assess which pond needs attention because the latest sensor readings are "
                "unavailable to me. Please check the dashboard for current readings before changing pond operations."
            )
        return (
            "The latest readings available to me are: "
            f"reservoir water level {sensor_data['water_level']}%, "
            f"evaporation pond temperature {sensor_data['temperature']} °C and humidity "
            f"{sensor_data['humidity']}%, and crystallizer salinity {sensor_data['salinity']} ppt. "
            "I don't have your configured operating thresholds here, so I can't reliably label a pond as needing "
            "attention. Compare these readings with your pond-specific limits."
        )

    if "readiness" in question or "brs" in question:
        return (
            "The Brine Readiness Score summarizes whether brine conditions are suitable for the next production "
            "stage. I can't calculate a current score offline without the validated scoring data; check the "
            "dashboard for the latest score."
        )

    if not readings_available:
        return (
            "I can't reach the AI service right now, and the latest pond readings were not available to me. "
            "I won't guess at current conditions; please check the dashboard's latest readings and try again."
        )

    return (
        "The AI service is temporarily unavailable. The latest readings available to me are "
        f"water level {sensor_data['water_level']}%, temperature {sensor_data['temperature']} °C, "
        f"humidity {sensor_data['humidity']}%, and salinity {sensor_data['salinity']} ppt. "
        "Ask me about one of these readings or check the dashboard for the latest pond conditions."
    )


@bp.route("/chat", methods=["POST"])
def chat():
    try:
        data = request.get_json()

        if not data or "message" not in data:
            return jsonify({
                "error": "Message is required"
            }), 400

        user_message = data["message"].strip()

        if not user_message:
            return jsonify({
                "error": "Message cannot be empty"
            }), 400

        # ---------------------------------------------------------
        # GET CURRENT DATA FROM SUPABASE
        # ---------------------------------------------------------
        sensor_data = SensorService.get_sensor_data()

        # Get recent sensor history
        history = SensorService.get_sensor_history()

        # ---------------------------------------------------------
        # PREPARE SENSOR HISTORY AND CURRENT DATA
        # ---------------------------------------------------------
        history_text = ""

        if history:
            for reading in history[:10]:
                history_text += f"""
- Pond ID: {reading.get('pond_id', 'N/A')}
  Temperature: {reading.get('temperature', 'N/A')} °C
  Humidity: {reading.get('humidity', 'N/A')} %
  Salinity: {reading.get('salinity', 'N/A')} ppt
  Water Level: {reading.get('water_level', 'N/A')} %
  Recorded At: {reading.get('recorded_at', 'N/A')}
"""

        if not history_text:
            history_text = "No historical sensor readings are available."

        if sensor_data.get("timestamp"):
            current_sensor_data_text = f"""
Water Level: {sensor_data.get('water_level', 'N/A')} %
Temperature: {sensor_data.get('temperature', 'N/A')} °C
Humidity: {sensor_data.get('humidity', 'N/A')} %
Salinity: {sensor_data.get('salinity', 'N/A')} ppt
Timestamp: {sensor_data.get('timestamp')}
"""
        else:
            current_sensor_data_text = (
                "UNAVAILABLE: The latest sensor data could not be retrieved. "
                "Do not interpret default values as actual readings."
            )

        # ---------------------------------------------------------
        # SEND REAL DATA TO GEMINI
        # ---------------------------------------------------------
        prompt = f"""
You are BrineFlow AI, an intelligent assistant for a solar saltpan
management system.

Your job is to help a saltpan operator understand the current
condition of their ponds.

BrineFlow has three main ponds:

1. Reservoir Pond
2. Evaporation Pond
3. Crystallizer Pond

BrineFlow monitors:
- Water level
- Salinity
- Temperature
- Humidity
- Weather
- Yield prediction
- Profit prediction
- Alerts
- Brine Readiness Score (BRS)
- Brine transfer recommendations

==================================================
CURRENT SENSOR DATA
==================================================

{current_sensor_data_text}

==================================================
RECENT SENSOR HISTORY
==================================================

{history_text}

==================================================
IMPORTANT RULES
==================================================

- Use the sensor values above when answering questions about
  current pond conditions.
- Do not invent sensor values.
- If a value is unavailable, clearly say that it is unavailable.
- Keep answers simple and useful for a saltpan operator.
- If the user asks which pond needs attention, explain why.
- If the user asks about salinity, temperature, humidity or
  water level, use the actual values provided above.
- If the user asks about BrineFlow itself, explain the project.
- Do not claim that a sensor is healthy unless the available
  data supports it.
- Do not make up weather, yield or profit values if they are
  not provided.
- When appropriate, give a short recommendation.

==================================================
USER QUESTION
==================================================

{user_message}
"""

        # ---------------------------------------------------------
        # GEMINI REQUEST
        # ---------------------------------------------------------
        reply = _generate_ai_reply(prompt, user_message, sensor_data)

        return jsonify({
            "reply": reply,
            "sensor_data": sensor_data
        }), 200

    except Exception as e:
        print("Gemini error:", e)

        return jsonify({
            "error": "Unable to get AI response",
            "details": str(e)
        }), 500