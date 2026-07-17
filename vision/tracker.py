"""Seguimiento de objetos detectados."""


class Tracker:
    def update(self, detections):
        raise NotImplementedError("Actualización de tracker no implementada")
