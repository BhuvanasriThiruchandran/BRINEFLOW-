from dataclasses import dataclass


@dataclass
class Weather:
    temperature: float
    humidity: int
    rain_probability: int
    wind_speed: float
    condition: str