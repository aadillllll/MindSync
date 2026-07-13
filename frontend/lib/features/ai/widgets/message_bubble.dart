import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import '../models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 330),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF7C5CFF) : const Color(0xFF182135),
          borderRadius: BorderRadius.circular(18),
        ),
        child: isUser
            ? Text(
                message.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.5,
                ),
              )
            : MarkdownBody(
                selectable: true,

                data: message.text,

                shrinkWrap: true,

                styleSheet: MarkdownStyleSheet(
                  p: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.6,
                  ),

                  h1: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),

                  h2: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),

                  h3: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),

                  strong: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),

                  em: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),

                  blockquote: const TextStyle(
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),

                  listBullet: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),

                  code: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 14,
                  ),

                  codeblockDecoration: BoxDecoration(
                    color: const Color(0xFF101827),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  tableHead: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),

                  tableBody: const TextStyle(color: Colors.white),

                  horizontalRuleDecoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.white24)),
                  ),
                ),
              ),
      ),
    );
  }
}
