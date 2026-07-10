from google import genai

from app.core.config import settings


class GeminiService:
    def __init__(self):
        self.client = genai.Client(api_key=settings.GEMINI_API_KEY)

    def generate_response(self, prompt: str) -> str:
        response = self.client.models.generate_content(
            model="gemini-2.0-flash",
            contents=prompt,
        )

        return response.text or "No response generated."