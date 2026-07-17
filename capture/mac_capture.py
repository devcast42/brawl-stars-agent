import cv2
import numpy as np
import time

from mss import mss

from .base import Capture
from .frame import Frame
from .window import WindowFinder


class MacCapture(Capture):

    TOP_BAR = 36
    RIGHT_BAR = 64

    def __init__(self):

        self.sct = mss()
        self.window = WindowFinder()

    def grab(self):

        w = self.window.find()

        monitor = {
            "left": w["x"],
            "top": w["y"] + self.TOP_BAR,
            "width": w["width"] - self.RIGHT_BAR,
            "height": w["height"] - self.TOP_BAR
        }

        img = np.array(self.sct.grab(monitor))

        img = cv2.cvtColor(
            img,
            cv2.COLOR_BGRA2BGR
        )

        return Frame(
            image=img,
            timestamp=time.time(),
            width=img.shape[1],
            height=img.shape[0]
        )