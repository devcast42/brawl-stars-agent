import Foundation
import ScreenCaptureKit

@available(macOS 15.0, *)
struct WindowFinder {

    static func blueStacksWindow() async throws -> SCWindow {

        let content = try await SCShareableContent.current

        guard let window = content.windows.first(where: {

            let appName = $0.owningApplication?.applicationName ?? ""
            let title = $0.title ?? ""

            return appName == "BlueStacks" &&
                   title == "BlueStacks Air"

        }) else {

            throw NSError(
                domain: "CaptureBridge",
                code: 1,
                userInfo: [
                    NSLocalizedDescriptionKey: "No se encontró la ventana de BlueStacks Air"
                ]
            )

        }

        return window
    }
}