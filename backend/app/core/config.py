import os
from dotenv import load_dotenv

load_dotenv()


class Settings:
    # Gemini (optional, can remove later)
    GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")

    # OpenRouter
    OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")
    AI_MODEL = os.getenv("AI_MODEL", "openrouter/free")


settings = Settings()