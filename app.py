import cv2

from capture.mac_capture import MacCapture

capture = MacCapture()

while True:

    frame = capture.grab()

    cv2.imshow("Game", frame.image)

    if cv2.waitKey(1) == 27:
        break

cv2.destroyAllWindows()