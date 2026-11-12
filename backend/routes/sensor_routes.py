from flask import Blueprint, jsonify, request
from services.sensor_service import SensorService

sensor_bp = Blueprint(
    "sensor",
    __name__,
    url_prefix="/api/sensors"
)


@sensor_bp.route("/", methods=["GET"])
def get_sensor():
    return jsonify(SensorService.get_sensor_data())


@sensor_bp.route("/history", methods=["GET"])
def get_history():
    return jsonify(SensorService.get_sensor_history())


@sensor_bp.route("/upload", methods=["POST"])
def upload_sensor_data():
    """
    Receive sensor data from ESP32 or simulated request.
    """

    try:
        data = request.get_json()

        if not data:
            return jsonify({
                "success": False,
                "message": "No JSON data received"
            }), 400

        required_fields = [
            "pond_id",
            "temperature",
            "humidity",
            "salinity",
            "water_level"
        ]

        for field in required_fields:
            if field not in data:
                return jsonify({
                    "success": False,
                    "message": f"Missing field: {field}"
                }), 400

        result = SensorService.save_sensor_data(data)

        return jsonify({
            "success": True,
            "message": "Sensor data received successfully",
            "data": result
        }), 200

    except Exception as e:
        return jsonify({
            "success": False,
            "message": str(e)
        }), 500


@sensor_bp.route("/health", methods=["GET"])
def health():
    return jsonify({
        "status": "healthy"
    })