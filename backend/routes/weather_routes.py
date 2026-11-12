from flask import Blueprint, jsonify

from services.weather_service import WeatherService

bp = Blueprint(
    "weather",
    __name__,
    url_prefix="/api/weather"
)


@bp.route("/", methods=["GET"])
def current_weather():
    return jsonify(
        WeatherService.get_current_weather()
    )


@bp.route("/forecast", methods=["GET"])
def forecast():
    return jsonify(
        WeatherService.get_forecast()
    )


@bp.route("/health", methods=["GET"])
def health():
    return jsonify({
        "status": "healthy"
    })