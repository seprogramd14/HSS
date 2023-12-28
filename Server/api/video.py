from fastapi import APIRouter
from fastapi.responses import StreamingResponse
from service.video import get_streaming_video


router = APIRouter(prefix='/video')
# video : 실시간 스트리밍 화면 출력 api


@router.get('', status_code=206)
async def open_video():
    return StreamingResponse(get_streaming_video(), media_type="multipart/x-mixed-replace; boundary=frame")
