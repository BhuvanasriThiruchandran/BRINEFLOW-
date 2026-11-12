"""Entry point for the BrineFlow Flask backend."""

from flask import Flask
from flask_cors import CORS
from dotenv import load_dotenv

from config.settings import Config

load_dotenv()

# Import Blueprints

# Import Blueprints
from routes.auth_routes import bp as auth_bp
from routes.sensor_routes import sensor_bp
from routes.weather_routes import bp as weather_bp
from routes.prediction_routes import bp as prediction_bp
from routes.alert_routes import bp as alert_bp
from routes.ai_routes import bp as ai_bp

app = Flask(__name__)
app.config.from_object(Config)

# Enable CORS
CORS(app)

# Register Blueprints
app.register_blueprint(auth_bp)
app.register_blueprint(sensor_bp)
app.register_blueprint(weather_bp)
app.register_blueprint(prediction_bp)
app.register_blueprint(alert_bp)
app.register_blueprint(ai_bp)

@app.route("/", methods=["GET"])
def health_check():
    return {
        "status": "ok",
        "service": "brineflow-backend"
    }


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
    