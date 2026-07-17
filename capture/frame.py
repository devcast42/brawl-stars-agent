from dataclasses import dataclass
import numpy as np
import time


@dataclass(slots=True)
class Frame:
    image: np.ndarray
    timestamp: float
    width: int
    height: int