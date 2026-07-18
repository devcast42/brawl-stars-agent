import Foundation
import CZMQ

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

        print("📡 Frame listo para enviar (\(frame.data.count) bytes)")

    }
}