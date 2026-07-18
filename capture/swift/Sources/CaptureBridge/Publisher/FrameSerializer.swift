import Foundation

enum FrameSerializer {

    static func serialize(_ frame: EncodedFrame) -> Data {

        var data = Data()

        var width = UInt32(frame.width).littleEndian
        var height = UInt32(frame.height).littleEndian
        var bytesPerRow = UInt32(frame.bytesPerRow).littleEndian
        var payloadSize = UInt32(frame.data.count).littleEndian

        withUnsafeBytes(of: &width) {
            data.append(contentsOf: $0)
        }

        withUnsafeBytes(of: &height) {
            data.append(contentsOf: $0)
        }

        withUnsafeBytes(of: &bytesPerRow) {
            data.append(contentsOf: $0)
        }

        withUnsafeBytes(of: &payloadSize) {
            data.append(contentsOf: $0)
        }

        data.append(frame.data)

        return data
    }

}