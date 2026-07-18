import CoreVideo
import Foundation

struct EncodedFrame {
    let data: Data
    let width: Int
    let height: Int
    let bytesPerRow: Int
}

enum FrameEncoder {

    static func encode(_ pixelBuffer: CVPixelBuffer) -> EncodedFrame? {

        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        defer {
            CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
        }

        guard let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer) else {
            return nil
        }

        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)

        let size = bytesPerRow * height

        let data = Data(
            bytes: baseAddress,
            count: size
        )

        return EncodedFrame(
            data: data,
            width: width,
            height: height,
            bytesPerRow: bytesPerRow
        )
    }

}
