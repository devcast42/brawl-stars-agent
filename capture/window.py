from Quartz import (
    CGWindowListCopyWindowInfo,
    kCGWindowListOptionOnScreenOnly,
    kCGNullWindowID
)


class WindowFinder:

    OWNER = "BlueStacks"

    def find(self):

        windows = CGWindowListCopyWindowInfo(
            kCGWindowListOptionOnScreenOnly,
            kCGNullWindowID
        )

        for w in windows:

            if w.get("kCGWindowOwnerName") != self.OWNER:
                continue

            bounds = w["kCGWindowBounds"]

            return {
                "x": int(bounds["X"]),
                "y": int(bounds["Y"]),
                "width": int(bounds["Width"]),
                "height": int(bounds["Height"]),
            }

        raise RuntimeError("BlueStacks no encontrado.")