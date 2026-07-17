"""Detector basado en YOLO."""


class YoloDetector:
    def __init__(self, model_path=None):
        self.model_path = model_path

    def load_model(self):
        raise NotImplementedError("Carga de modelo no implementada")
