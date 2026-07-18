import CZMQ
import Foundation

final class ZeroMQPublisher: FrameTransport {

    private let context: UnsafeMutableRawPointer
    private let socket: UnsafeMutableRawPointer

    init() {

        guard let context = zmq_ctx_new() else {
            fatalError("No se pudo crear el contexto ZeroMQ")
        }

        guard let socket = zmq_socket(context, ZMQ_PUSH) else {
            zmq_ctx_term(context)
            fatalError("No se pudo crear el socket ZeroMQ")
        }

        self.context = context
        self.socket = socket

        let endpoint = "tcp://127.0.0.1:5555"

        if zmq_connect(socket, endpoint) != 0 {
            let error = String(cString: zmq_strerror(zmq_errno()))
            fatalError("Error conectando: \(error)")
        }

        print("✅ ZeroMQ conectado a \(endpoint)")
    }

    deinit {
        zmq_close(socket)
        zmq_ctx_term(context)
    }

    func send(_ frame: EncodedFrame) throws {

        let message = FrameSerializer.serialize(frame)

        message.withUnsafeBytes { buffer in

            guard let base = buffer.baseAddress else {
                return
            }

            zmq_send(
                socket,
                base,
                message.count,
                0
            )
        }

    }
}
