from dataclasses import dataclass


@dataclass
class Prediction:
    expected_yield: float
    expected_profit: float
    efficiency: float
    harvest_days: int