from datetime import datetime


class WeatherService:

    @staticmethod
    def get_current_weather():
        return {
            "temperature": 34,
            "humidity": 67,
            "rain_probability": 15,
            "wind_speed": 12.5,
            "condition": "Sunny",
            "timestamp": datetime.now().isoformat()
        }

    @staticmethod
    def get_forecast():

        forecast = []

        forecast.append({
            "day": "Today",
            "temperature": 34,
            "condition": "Sunny"
        })

        forecast.append({
            "day": "Tomorrow",
            "temperature": 33,
            "condition": "Partly Cloudy"
        })

        forecast.append({
            "day": "Day 3",
            "temperature": 31,
            "condition": "Rain"
        })

        return forecast