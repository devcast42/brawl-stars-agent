import Foundation
import AppKit

@available(macOS 15.0, *)
@main
struct CaptureBridge {

    static func main() async {

        // Inicializa AppKit
        _ = NSApplication.shared

        do {

            let manager = StreamManager()

            try await manager.start()

            while true {
                try await Task.sleep(for: .seconds(1))
            }

        } catch {

            print(error)

        }
    }
}