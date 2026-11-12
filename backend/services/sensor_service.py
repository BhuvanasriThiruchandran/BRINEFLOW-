from datetime import datetime
from database.supabase_client import supabase


class SensorService:

    @staticmethod
    def get_sensor_data():
        """
        Get the latest current values from the ponds table.
        """

        try:
            ponds_response = (
                supabase
                .table("ponds")
                .select("*")
                .order("id")
                .execute()
            )

            ponds = ponds_response.data

            if not ponds or len(ponds) < 3:
                raise Exception("Less than 3 ponds found in Supabase")

            reservoir = ponds[0]
            evaporation = ponds[1]
            crystallizer = ponds[2]

            return {
                "water_level": reservoir.get("current_level", 0),
                "temperature": evaporation.get("temperature", 0),
                "humidity": evaporation.get("humidity", 0),
                "salinity": crystallizer.get("salinity", 0),
                "timestamp": datetime.utcnow().isoformat()
            }

        except Exception as e:
            print("Sensor data error:", e)

            return {
                "water_level": 0,
                "temperature": 0,
                "humidity": 0,
                "salinity": 0,
                "timestamp": ""
            }


    @staticmethod
    def get_sensor_history():
        """
        Get recent sensor readings.
        """

        try:
            history = (
                supabase
                .table("sensor_readings")
                .select("*")
                .order("recorded_at", desc=True)
                .limit(20)
                .execute()
            )

            return history.data

        except Exception as e:
            print("Sensor history error:", e)
            return []


    @staticmethod
    def save_sensor_data(data):
        """
        Save incoming sensor data and update pond values.
        """

        try:
            # -------------------------------------------------
            # Save sensor reading
            # -------------------------------------------------

            supabase.table("sensor_readings").insert({
                "pond_id": data["pond_id"],
                "temperature": data["temperature"],
                "humidity": data["humidity"],
                "salinity": data["salinity"],
                "water_level": data["water_level"],
                "recorded_at": datetime.utcnow().isoformat()
            }).execute()


            # -------------------------------------------------
            # Update Reservoir Pond
            # -------------------------------------------------

            supabase.table("ponds").update({
                "current_level": data["water_level"]
            }).eq("id", 1).execute()


            # -------------------------------------------------
            # Update Evaporation Pond
            # -------------------------------------------------

            supabase.table("ponds").update({
                "temperature": data["temperature"],
                "humidity": data["humidity"]
            }).eq("id", 2).execute()


            # -------------------------------------------------
            # Update Crystallizer Pond
            # -------------------------------------------------

            supabase.table("ponds").update({
                "salinity": data["salinity"]
            }).eq("id", 3).execute()


            print("Sensor data saved successfully.")

            return data


        except Exception as e:

            print("Save sensor data error:", e)

            raise e