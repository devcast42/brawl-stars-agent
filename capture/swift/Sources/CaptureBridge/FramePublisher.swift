import CoreImage
import CoreVideo
import Foundation
import ImageIO
import UniformTypeIdentifiers

final class FramePublisher {

    private let context = CIContext()

    func publish(_ pixelBuffer: CVPixelBuffer) {

        print("📦 publish()")

        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)

        print("CI extent: \(ciImage.extent)")

        guard let cgImage = context.createCGImage(
            ciImage,
            from: ciImage.extent
        ) else {
            print("❌ No se pudo crear CGImage")
            return
        }

        print("✅ CGImage creada")

        let capturesURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            .appendingPathComponent("captures")

        do {
            try FileManager.default.createDirectory(
                at: capturesURL,
                withIntermediateDirectories: true
            )
        } catch {
            print(error)
        }

        let url = capturesURL.appendingPathComponent("frame.png")

        print("Guardando en:")
        print(url.path)

        guard let destination = CGImageDestinationCreateWithURL(
            url as CFURL,
            UTType.png.identifier as CFString,
            1,
            nil
        ) else {
            print("❌ No se pudo crear destino")
            return
        }

        CGImageDestinationAddImage(destination, cgImage, nil)

        if CGImageDestinationFinalize(destination) {
            print("✅ Imagen guardada")
        } else {
            print("❌ Error al guardar")
        }

        print("PixelBuffer: \(CVPixelBufferGetWidth(pixelBuffer))x\(CVPixelBufferGetHeight(pixelBuffer))")
    }
}