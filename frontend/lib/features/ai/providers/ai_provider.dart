import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/ai_message.dart';
import '../services/ai_service.dart';

class AIProvider extends ChangeNotifier {
  final AIService _service = AIService();

  final List<AIMessage> _messages = [];

  List<AIMessage> get messages => List.unmodifiable(_messages);

  bool _loading = false;

  bool get loading => _loading;

  final String conversationId = const Uuid().v4();

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    _messages.add(
      AIMessage(
        id: const Uuid().v4(),
        conversationId: conversationId,
        role: MessageRole.user,
        content: message,
        createdAt: DateTime.now(),
      ),
    );

    _loading = true;
    notifyListeners();

    try {
      final reply = await _service.sendMessage(
        conversationId: conversationId,
        userPrompt: message,
      );

      _messages.add(reply);
    } catch (e) {
      _messages.add(
        AIMessage(
          id: const Uuid().v4(),
          conversationId: conversationId,
          role: MessageRole.assistant,
          content: "Sorry, I couldn't generate a response.\n\n$e",
          createdAt: DateTime.now(),
        ),
      );
    }

    _loading = false;
    notifyListeners();
  }

  void clearChat() {
    _messages.clear();
    notifyListeners();
  }
}
