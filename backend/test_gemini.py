from google import genai
from dotenv import load_dotenv
import os
import traceback

load_dotenv()

try:
    print("Loading API key...")

    api_key = os.getenv("GEMINI_API_KEY")
    print("API Key:", api_key[:10] + "..." if api_key else "NOT FOUND")

    print("Creating client...")

    client = genai.Client(api_key=api_key)

    print("Sending request...")

    response = client.models.generate_content(
        model="gemini-2.0-flash",
        contents="Say hello."
    )

    print("Response received:")
    print(response.text)

except Exception as e:
    print("\nERROR:")
    traceback.print_exc()