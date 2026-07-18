import CoreVideo

final class ZeroMQPublisher: FrameTransport {

    func send(
        pixelBuffer: CVPixelBuffer
    ) throws {

        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)

        print("📡 Enviando frame \(width)x\(height)")

    }

}