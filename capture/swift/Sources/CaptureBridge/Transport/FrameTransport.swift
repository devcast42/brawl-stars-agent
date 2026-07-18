import CoreVideo

protocol FrameTransport {

    func send(
        _ frame: EncodedFrame
    ) throws

}