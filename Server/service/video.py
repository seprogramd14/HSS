import cv2


async def get_streaming_video():
    cam = cv2.VideoCapture(0, cv2.CAP_DSHOW)
    try:
        while True:
            # 카메라 값 불러오기
            success, frame = cam.read()

            if not success:
               break
            # frame을 byte로 변경 후 특정 식??으로 변환 후 yield로 하나씩 넘겨준다.

            ret, buffer = cv2.imencode('.jpg', frame)
            frame = buffer.tobytes()
            yield b'--frame\r\n' b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n'
    finally:
        cam.release()
