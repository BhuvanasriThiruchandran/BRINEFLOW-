from datetime import datetime

class AlertService:

    @staticmethod
    def get_alerts():

        return [
            {
                "id": 1,
                "title": "High Temperature",
                "message": "Temperature exceeded 35°C.",
                "severity": "High",
                "timestamp": datetime.now().isoformat()
            },
            {
                "id": 2,
                "title": "Low Water Level",
                "message": "Reservoir water level below 25%.",
                "severity": "Medium",
                "timestamp": datetime.now().isoformat()
            },
            {
                "id": 3,
                "title": "Rain Warning",
                "message": "Rain expected within 24 hours.",
                "severity": "High",
                "timestamp": datetime.now().isoformat()
            }
        ]

    @staticmethod
    def get_alert(alert_id):

        for alert in AlertService.get_alerts():
            if alert["id"] == alert_id:
                return alert

        return None