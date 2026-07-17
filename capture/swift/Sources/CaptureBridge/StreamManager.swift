import Foundation
import ScreenCaptureKit
import CoreMedia

@available(macOS 15.0, *)
final class StreamManager {

    private var stream: SCStream?
    private let publisher = FramePublisher()
    private lazy var output = StreamOutput(publisher: publisher)

    func start() async throws {

        print("🔍 Buscando BlueStacks...")

        let content = try await SCShareableContent.current

        guard let window = content.windows.first(where: {
            ($0.owningApplication?.applicationName ?? "") == "BlueStacks" &&
            ($0.title ?? "") == "BlueStacks Air"
        }) else {
            throw NSError(
                domain: "CaptureBridge",
                code: 1,
                userInfo: [
                    NSLocalizedDescriptionKey: "No se encontró BlueStacks Air"
                ]
            )
        }

        guard let display = content.displays.first(where: {
            $0.frame.intersects(window.frame)
        }) else {
            throw NSError(
                domain: "CaptureBridge",
                code: 2,
                userInfo: [
                    NSLocalizedDescriptionKey: "No se encontró el display"
                ]
            )
        }

        let filter = SCContentFilter(
            desktopIndependentWindow: window
        )

        let configuration = SCStreamConfiguration()

        configuration.width = Int(window.frame.width)
        configuration.height = Int(window.frame.height)

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
