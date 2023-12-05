# https://github.com/biplob004/live_face_recognition/blob/main/wcam.ipynb 참고

# 수정할 사안 : Databases에 사진이 없을 때 -> 오류 발생, UNKNOWN 표시, 여러 사람 인식 가능한 지

from facenet_pytorch import MTCNN, InceptionResnetV1  # 이거 알아야 함
import torch
from torchvision import datasets
from torch.utils.data import DataLoader
from PIL import Image
import os
import cv2
import argparse

# parser 설정
parser = argparse.ArgumentParser()
parser.add_argument("-name", "--name", type=str, help="입력한 이름으로 사진을 저장하고 자동으로 data.pt를 생성한다.")

args = parser.parse_args()


# 31 line에서 사용
def collate_fn(x):
    return x[0]


# data.pt 새로 만듦
def create_data():
    dataset = datasets.ImageFolder('Databases')
    idx_to_class = {index: c for c, index in dataset.class_to_idx.items()}

    loader = DataLoader(dataset, collate_fn=collate_fn)

    create_name_list = []
    create_embedding_list = []

    for load_img, idx in loader:  # img는 pil 이미지이다.
        face, prob_ = mtcnn0(load_img, return_prob=True)
        if face is not None and prob_ > 0.92:
            emb_ = resnet(face.unsqueeze(0))
            create_embedding_list.append(emb_.detach())
            create_name_list.append(idx_to_class[idx])

    data = [create_embedding_list, create_name_list]
    torch.save(data, 'data.pt')


# 사진 저장
def saving_db(ar_name):

    if not os.path.exists('Databases/'+ar_name):
        os.mkdir("Databases/"+ar_name)

    while True:
        ret1, frame1 = cam.read()
        if not ret1:
            print("ret이 없습니다.")
            break

        cv2.imshow("saving Image", frame1)

        if cv2.waitKey(33) == 13:  # Enter 키 입력
            cv2.imwrite(f"Databases/{ar_name}/{ar_name}.png", frame1)
            print("saving Image")
            break


# 거리 구하기
def distance(embed):
    re_dist_list = []

    for idx, emb_db in enumerate(embedding_list):
        dist = torch.dist(embed, emb_db).item()
        re_dist_list.append(dist)

    return re_dist_list


# 불러오기
try:
    load_data = torch.load('data.pt')
except Exception as e:
    print("data.pt 파일이 생성되지 않았습니다.")
    exit()  # 코드 탈출

embedding_list = load_data[0]
name_list = load_data[1]

# 카메라 설정
cam = cv2.VideoCapture(0)

# 모델 설정
mtcnn0 = MTCNN(image_size=240, margin=0, keep_all=False, min_face_size=40)  # 하나의 얼굴만
mtcnn = MTCNN(image_size=240, margin=0, keep_all=True, min_face_size=40)  # 다른 것도 ok
resnet = InceptionResnetV1(pretrained='vggface2').eval()


# 실행
while True:
    ret, frame = cam.read()  # 필수
    if not ret:  # 필수
        print("ret이 없습니다.")
        break

    mirror_frame = cv2.flip(frame, 1)
    img = Image.fromarray(mirror_frame)  # 필수
    img_cropped_list, prob_list = mtcnn(img, return_prob=True)  # 필수

    if args.name is not None:  # 이름을 입력했을 때
        saving_db(args.name)
        create_data()
        break

    if img_cropped_list is not None:  # 필수
        boxes, _ = mtcnn.detect(img)  # 필수

        for i, prob in enumerate(prob_list):
            if prob > 0.90:  # 얼굴인지 아닌지 확인
                emb = resnet(img_cropped_list[i].unsqueeze(0)).detach()

                dist_list = distance(emb)  # 거리 함수

                min_dist = min(dist_list)
                min_dist_idx = dist_list.index(min_dist)
                name = name_list[min_dist_idx]
                box = boxes[i]

                if min_dist > 0.71:
                    cv2.putText(mirror_frame, name + ' ' + str(int(min_dist*100)) + '%', (int(box[0]), int(box[1])),
                                cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 1, cv2.LINE_AA)
                else:
                    cv2.putText(mirror_frame, "UNKNOWN", (int(box[0]), int(box[1])), cv2.FONT_HERSHEY_SIMPLEX,
                                1, (0, 255, 0), 1, cv2.LINE_AA)

                print(min_dist)
                cv2.rectangle(mirror_frame, (int(box[0]), int(box[1])), (int(box[2]), int(box[3])), (0, 255, 0), 2)

    cv2.imshow('frame', mirror_frame)

    if cv2.waitKey(33) == 27:
        break

cam.release()
cv2.destroyAllWindows()
