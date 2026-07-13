import 'package:flutter/material.dart';
import '../models/ai_conversation.dart';
import '../models/chat_message.dart';
import '../services/ai_conversation_service.dart';
import '../services/ai_service.dart';

class AIProvider extends ChangeNotifier {
  final AIService _service = AIService();
  final AIConversationService _conversationService = AIConversationService();

  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  bool _loading = false;

  bool get loading => _loading;

  String? _conversationId;

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Create conversation on first message
    if (_conversationId == null) {
      _conversationId = await _conversationService.createConversation();
    }

    final userMessage = ChatMessage(text: message, isUser: true);

    _messages.add(userMessage);

    notifyListeners();

    await _conversationService.saveMessage(
      conversationId: _conversationId!,
      role: "user",
      content: message,
    );

    await loadConversations();

    _loading = true;
    notifyListeners();

    try {
      final result = await _service.sendMessage(message, _messages);

      final reply = result["response"];
      final title = result["title"];

      _messages.add(ChatMessage(text: reply, isUser: false));

      await _conversationService.saveMessage(
        conversationId: _conversationId!,
        role: "assistant",
        content: reply,
      );

      if (title != null && title.toString().trim().isNotEmpty) {
        await _conversationService.updateTitle(_conversationId!, title);

        await loadConversations();
      }
    } catch (e, stackTrace) {
      debugPrint("AI ERROR: $e");
      debugPrintStack(stackTrace: stackTrace);

      _messages.add(
        ChatMessage(
          text: "Unable to contact MindSync AI.\n\n$e",
          isUser: false,
        ),
      );
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> newConversation() async {
    _conversationId = null;
    _messages.clear();

    notifyListeners();
  }

  final List<AIConversation> _conversations = [];

  List<AIConversation> get conversations => _conversations;

  Future<void> loadConversations() async {
    _conversations.clear();

    _conversations.addAll(await _conversationService.getConversations());

    notifyListeners();
  }

  Future<void> openConversation(AIConversation conversation) async {
    _conversationId = conversation.id;

    _messages.clear();

    _messages.addAll(await _conversationService.getMessages(conversation.id));

    notifyListeners();
  }
}
