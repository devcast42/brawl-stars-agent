import CoreVideo
import Foundation

final class FramePublisher {

    private let transport: FrameTransport

    init(transport: FrameTransport) {
        self.transport = transport
    }

    func publish(_ pixelBuffer: CVPixelBuffer) {

        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)

        print("📦 Publicando frame \(width)x\(height)")

        do {
            try transport.send(pixelBuffer: pixelBuffer)
        } catch {
            print("❌ Error enviando frame: \(error)")
        }
    }
}