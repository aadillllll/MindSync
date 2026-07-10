from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

from app.services.ai_service import AIService

router = APIRouter(prefix="/ai", tags=["AI"])


class ChatRequest(BaseModel):
    message: str


class ChatResponse(BaseModel):
    response: str


service = AIService()


@router.post("/chat", response_model=ChatResponse)
def chat(request: ChatRequest):
    try:
        answer = service.generate_response(request.message)
        return ChatResponse(response=answer)

    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=str(e),
        )
        