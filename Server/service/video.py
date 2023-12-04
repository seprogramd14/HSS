import cv2


def get_streaming_video():
    cam = cv2.VideoCapture(0, cv2.CAP_DSHOW)

    while True:
        success, frame = cam.read()
        if not success:
            break

        ret, buffer = cv2.imencode('.jpg', frame)
        frame = buffer.tobytes()

        # 비동기 대기 처리
        yield (b'--frame\r\n' b'Content-Type: image/jpeg\r\n\r\n' + bytearray(frame) + b'\r\n')
