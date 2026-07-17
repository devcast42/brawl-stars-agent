import Foundation

@available(macOS 15.0, *)
@main
struct CaptureBridge {

    static func main() async {

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