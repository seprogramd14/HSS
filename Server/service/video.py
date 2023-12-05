import cv2
from facenet_pytorch import MTCNN, InceptionResnetV1  # 이거 알아야 함
import torch
from torchvision import datasets
from torch.utils.data import DataLoader

mtcnn0 = MTCNN(image_size=240, margin=0, keep_all=False, min_face_size=40)  # 하나의 얼굴만
resnet = InceptionResnetV1(pretrained='vggface2').eval()


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


async def make_data_pt():
    dataset = datasets.ImageFolder('image')
    idx_to_class = {index: c for c, index in dataset.class_to_idx.items()}

    loader = DataLoader(dataset, collate_fn=lambda x: x[0])

    create_name_list = []
    create_embedding_list = []

    for load_img, idx in loader:  # img는 pil 이미지이다.
        face, prob_ = mtcnn0(load_img, return_prob=True)
        if face is not None and prob_ > 0.92:
            emb_ = resnet(face.unsqueeze(0))
            create_embedding_list.append(emb_.detach())
            create_name_list.append(idx_to_class[idx])

    data = [create_embedding_list, create_name_list]
    torch.save(data, './data_pt/data.pt')
