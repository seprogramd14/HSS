from fastapi import APIRouter
from fastapi.responses import StreamingResponse
from service.video import get_streaming_video

router = APIRouter(prefix='/video')


@router.get('/open', status_code=200)
def open_video():
    return StreamingResponse(get_streaming_video(), media_type="multipart/x-mixed-replace; boundary=frame")
