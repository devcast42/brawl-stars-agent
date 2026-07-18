import Foundation
import ScreenCaptureKit
import CoreMedia

@available(macOS 15.0, *)
final class StreamManager {

    private var stream: SCStream?
    private let publisher = FramePublisher(
        transport: ZeroMQPublisher()
    )
    private lazy var output = StreamOutput(publisher: publisher)

    func start() async throws {

    let window = try await WindowFinder.blueStacksWindow()

    let filter = SCContentFilter(desktopIndependentWindow: window)

    let configuration = SCStreamConfiguration()

    configuration.width = Int(window.frame.width)
    configuration.height = Int(window.frame.height)
    
    configuration.pixelFormat = kCVPixelFormatType_32BGRA

    configuration.minimumFrameInterval = CMTime(
        value: 1,
        timescale: 60
    )

    configuration.queueDepth = 5

    let stream = SCStream(
        filter: filter,
        configuration: configuration,
        delegate: nil
    )

    try stream.addStreamOutput(
        output,
        type: .screen,
        sampleHandlerQueue: .main
    )

    self.stream = stream

    try await stream.startCapture()

    print("🚀 Stream iniciado")
}
}
