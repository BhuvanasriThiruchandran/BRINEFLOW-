class PredictionService:

    @staticmethod
    def predict():

        salinity = 30
        temperature = 35
        humidity = 65
        water_level = 80

        expected_yield = salinity * 12.5
        efficiency = (temperature * 2 + salinity) / 100
        expected_profit = expected_yield * 45
        harvest_days = 12

        return {
            "salinity": salinity,
            "temperature": temperature,
            "humidity": humidity,
            "water_level": water_level,
            "expected_yield": round(expected_yield, 2),
            "expected_profit": round(expected_profit, 2),
            "efficiency": round(efficiency * 100, 2),
            "harvest_days": harvest_days
        }