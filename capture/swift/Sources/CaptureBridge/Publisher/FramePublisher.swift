import CoreVideo
import Foundation

final class FramePublisher {

    private let transport: FrameTransport

    init(transport: FrameTransport) {
        self.transport = transport
    }

    func publish(_ pixelBuffer: CVPixelBuffer) {

        guard let frame = FrameEncoder.encode(pixelBuffer) else {
            print("❌ No se pudo codificar el frame")
            return
        }

        print("📦 Publicando frame \(frame.width)x\(frame.height)")

        do {
            try transport.send(frame)
        } catch {
            print("❌ Error enviando frame: \(error)")
        }
    }
}