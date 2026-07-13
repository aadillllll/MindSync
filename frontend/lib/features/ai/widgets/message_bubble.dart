import 'package:flutter/material.dart';

import '../models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: message.isUser
              ? const Color(0xFF7C5CFF)
              : const Color(0xFF182135),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          message.text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
