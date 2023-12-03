import cv2


def get_streaming_video():
    cam = cv2.VideoCapture(0)

    while True:
        ret, frame = cam.read()
        if not ret:
            break

        # opencv 이미지 -> jpeg 포맷
        ret, jpg_frame = cv2.imencode('.jpg', frame)

        # 스트리밍을 위해 binary 형태로 변환
        jpg_frame_bin = bytearray(jpg_frame.tobytes())

        # 비동기 대기 처리
        yield (b'--PNPframe\r\n' b'Content-Type: image/jpeg\r\n\r\n' + jpg_frame_bin + b'\r\n')
