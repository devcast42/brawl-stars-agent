import Foundation
import ScreenCaptureKit
import CoreMedia
import CoreVideo

@available(macOS 15.0, *)
final class StreamOutput: NSObject, SCStreamOutput {

    private let publisher: FramePublisher

    init(publisher: FramePublisher) {
        self.publisher = publisher
    }

    func stream(
        _ stream: SCStream,
        didOutputSampleBuffer sampleBuffer: CMSampleBuffer,
        of outputType: SCStreamOutputType
    ) {

        guard outputType == .screen else {
            return
        }

        guard let pixelBuffer = sampleBuffer.imageBuffer else {
            return
        }

        publisher.publish(pixelBuffer)
    }
}