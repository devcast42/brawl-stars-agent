import CoreGraphics
import Foundation
import ImageIO
import ScreenCaptureKit
import UniformTypeIdentifiers

@available(macOS 15.0, *)
final class ScreenshotManager {

    func capture() async throws {

        print("Buscando BlueStacks...")

        let window = try await WindowFinder.blueStacksWindow()

        print("Ventana encontrada:")
        print(window.title ?? "")

        let config = SCStreamConfiguration()
        config.width = Int(window.frame.width)
        config.height = Int(window.frame.height)

        let content = try await SCShareableContent.current

        guard
            let display = content.displays.first(where: {
                $0.frame.intersects(window.frame)
            })
        else {
            fatalError("No display")
        }

        let filter = SCContentFilter(
            display: display,
            including: [window]
        )

        let image = try await SCScreenshotManager.captureImage(
            contentFilter: filter,
            configuration: config
        )

        let url = URL(fileURLWithPath: "./screenshot.png")

        guard
            let destination = CGImageDestinationCreateWithURL(
                url as CFURL,
                UTType.png.identifier as CFString,
                1,
                nil
            )
        else {
            throw NSError(domain: "CaptureBridge", code: -1)
        }

        CGImageDestinationAddImage(destination, image, nil)

        guard CGImageDestinationFinalize(destination) else {
            throw NSError(domain: "CaptureBridge", code: -2)
        }

        print("✅ Captura guardada en:")
        print(url.path)
    }
}
