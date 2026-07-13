from openai import OpenAI

from app.core.config import settings
from app.services.prompt_service import PromptService
from app.services.context_service import ContextService


class AIService:

    def __init__(self):
        self.client = OpenAI(
            api_key=settings.OPENROUTER_API_KEY,
            base_url="https://openrouter.ai/api/v1",
        )

    def generate_response(
        self,
        prompt: str,
        user_id: str,
        history: list = None,
    ):

        if history is None:
            history = []

        # -----------------------------
        # Smart Context
        # -----------------------------
        context = ContextService.build_context(
            prompt=prompt,
            user_id=user_id,
        )

        messages = [
            {
                "role": "system",
                "content": PromptService.get_system_prompt(),
            }
        ]

        # Give the AI the user's data
        if context.strip():
            messages.append(
                {
                    "role": "system",
                    "content": f"""
This is the current data stored inside MindSync for this user.

{context}

Always use this information whenever it helps answer the user's question.

If the user asks something unrelated,
ignore the data.
""",
                }
            )

        # -----------------------------
        # Previous conversation
        # -----------------------------
        for msg in history:
            messages.append(
                {
                    "role": msg.role,
                    "content": msg.content,
                }
            )

        # -----------------------------
        # Current user message
        # -----------------------------
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

        # Generate title only once
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
                    "content": "You generate very short conversation titles (2-5 words). Return only the title.",
                },
                {
                    "role": "user",
                    "content": PromptService.get_title_prompt(message),
                },
            ],
        )

        return response.choices[0].message.content.strip()