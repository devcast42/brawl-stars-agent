import CoreVideo

protocol FrameTransport {

    func send(
        pixelBuffer: CVPixelBuffer
    ) throws

}