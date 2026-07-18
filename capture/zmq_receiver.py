import struct

import cv2
import numpy as np
import zmq

context = zmq.Context()

socket = context.socket(zmq.PULL)
socket.bind("tcp://127.0.0.1:5555")

print("Esperando frames...")

while True:

    message = socket.recv()

    width, height, bytes_per_row, payload_size = struct.unpack(
        "<IIII",
        message[:16]
    )

    payload = message[16:]

    image = np.frombuffer(payload, dtype=np.uint8)

    image = image.reshape(height, bytes_per_row)

    image = image[:, : width * 4]

    image = image.reshape(height, width, 4)

    cv2.imshow("BlueStacks", image)

    if cv2.waitKey(1) == 27:
        break