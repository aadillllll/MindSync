import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception("Gemini API key not found.");
    }

    _model = GenerativeModel(model: 'gemini-2.5-flash-lite', apiKey: apiKey);
  }

  Future<String> generateResponse(String prompt) async {
    try {
      final response = await _model.generateContent([Content.text(prompt)]);

      return response.text ?? "No response generated.";
    } catch (e) {
      throw Exception("Gemini Error: $e");
    }
  }
}
