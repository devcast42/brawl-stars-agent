"""Detector principal para objetos en pantalla."""


class Detector:
    def __init__(self, model_path=None):
        self.model_path = model_path

    def detect(self, image):
        raise NotImplementedError("Detección no implementada")
