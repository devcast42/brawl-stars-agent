from abc import ABC, abstractmethod
from .frame import Frame


class Capture(ABC):

    @abstractmethod
    def grab(self) -> Frame:
        pass