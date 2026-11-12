from flask import Blueprint, jsonify

from services.prediction_service import PredictionService

bp = Blueprint(
    "prediction",
    __name__,
    url_prefix="/api/predictions"
)


@bp.route("/", methods=["GET"])
def predict():
    return jsonify(
        PredictionService.predict()
    )


@bp.route("/health", methods=["GET"])
def health():
    return jsonify({
        "status": "healthy"
    })