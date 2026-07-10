import 'package:flutter/foundation.dart';

import '../models/ai_message.dart';
import 'gemini_service.dart';
import 'prompt_builder.dart';

class AIService {
  final GeminiService _gemini = GeminiService();

  Future<AIMessage> sendMessage({
    required String conversationId,
    required String userPrompt,
    String? tasks,
    String? notes,
    String? calendar,
    String? goals,
  }) async {
    final prompt = PromptBuilder.build(
      userPrompt: userPrompt,
      tasks: tasks,
      notes: notes,
      calendar: calendar,
      goals: goals,
    );

    final response = await _gemini.generateResponse(prompt);

    debugPrint(prompt);

    return AIMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: conversationId,
      role: MessageRole.assistant,
      content: response,
      createdAt: DateTime.now(),
    );
  }
}
