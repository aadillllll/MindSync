from openai import OpenAI

from app.core.config import settings


class AIService:
    def __init__(self):
        self.client = OpenAI(
            api_key=settings.OPENROUTER_API_KEY,
            base_url="https://openrouter.ai/api/v1",
        )

    def generate_response(self, prompt: str) -> str:
        try:
            response = self.client.chat.completions.create(
                model=settings.AI_MODEL,
                messages=[
                    {
                        "role": "user",
                        "content": prompt,
                    }
                ],
            )

            return response.choices[0].message.content

        except Exception as e:
            raise Exception(f"OpenRouter Error: {str(e)}")