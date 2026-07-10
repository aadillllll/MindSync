from fastapi import FastAPI

from app.routes.ai import router as ai_router

app = FastAPI(title="MindSync Backend")

app.include_router(ai_router)