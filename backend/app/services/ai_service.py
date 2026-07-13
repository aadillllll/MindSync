from openai import OpenAI

from app.core.config import settings
from app.services.prompt_service import PromptService


class AIService:

    def __init__(self):
        self.client = OpenAI(
            api_key=settings.OPENROUTER_API_KEY,
            base_url="https://openrouter.ai/api/v1",
        )

    def generate_response(self, prompt: str, history=None) -> str:

        if history is None:
            history = []

        messages = [
            {
                "role": "system",
                "content": PromptService.get_system_prompt(),
            }
        ]

        # Add previous conversation
        for msg in history:
            messages.append(
                {
                    "role": msg.role,
                    "content": msg.content,
                }
            )

        # Add current user message
        messages.append(
            {
                "role": "user",
                "content": prompt,
            }
        )

        response = self.client.chat.completions.create(
    model=settings.AI_MODEL,
    messages=messages,
)

        reply = response.choices[0].message.content

        title = None

        # Generate a title only for a new conversation
        if len(history) <= 1:
            title = self.generate_title(prompt)

        return {
            "response": reply,
            "title": title,
        }
    def generate_title(self, message: str) -> str:

        response = self.client.chat.completions.create(
        model=settings.AI_MODEL,
        messages=[
            {
                "role": "system",
                "content": "You generate short conversation titles.",
            },
            {
                "role": "user",
                "content": PromptService.get_title_prompt(message),
            },
        ],
    )

        return response.choices[0].message.content.strip()