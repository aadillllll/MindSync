from typing import List
from pydantic import BaseModel


class HistoryMessage(BaseModel):
    role: str
    content: str


class ChatRequest(BaseModel):
    user_id: str
    message: str
    history: List[HistoryMessage] = []


class ChatResponse(BaseModel):
    response: str
    title: str | None = None