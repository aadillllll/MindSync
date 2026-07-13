from fastapi import APIRouter, HTTPException

from app.models.ai_models import ChatRequest, ChatResponse
from app.services.ai_service import AIService

router = APIRouter(
    prefix="/ai",
    tags=["AI"],
)

service = AIService()


@router.post("/chat", response_model=ChatResponse)
def chat(request: ChatRequest):

    try:

        result = service.generate_response(
            prompt=request.message,
            user_id=request.user_id,
            history=request.history,
        )

        return ChatResponse(
            response=result["response"],
            title=result["title"],
        )

    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=str(e),
        )