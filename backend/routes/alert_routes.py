from flask import Blueprint, jsonify

from services.alert_service import AlertService

bp = Blueprint(
    "alerts",
    __name__,
    url_prefix="/api/alerts"
)


@bp.route("/", methods=["GET"])
def get_alerts():

    return jsonify(
        AlertService.get_alerts()
    )


@bp.route("/<int:alert_id>", methods=["GET"])
def get_alert(alert_id):

    alert = AlertService.get_alert(alert_id)

    if alert:
        return jsonify(alert)

    return jsonify({
        "error": "Alert not found"
    }), 404


@bp.route("/health", methods=["GET"])
def health():

    return jsonify({
        "status": "healthy"
    })