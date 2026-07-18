final class ZeroMQPublisher: FrameTransport {

    func send(_ frame: EncodedFrame) throws {

        print("""
        📡 Frame recibido
        -----------------
        Width: \(frame.width)
        Height: \(frame.height)
        BytesPerRow: \(frame.bytesPerRow)
        Size: \(frame.data.count) bytes
        """)

    }
}