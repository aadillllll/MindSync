import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ai_provider.dart';
import 'recent_chat_card.dart';

class RecentChatSection extends StatelessWidget {
  const RecentChatSection({super.key});

  String _formatTime(DateTime date) {
    final difference = DateTime.now().difference(date);

    if (difference.inMinutes < 1) {
      return "Now";
    }

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min";
    }

    if (difference.inHours < 24) {
      return "${difference.inHours} hr";
    }

    if (difference.inDays == 1) {
      return "Yesterday";
    }

    return "${difference.inDays} days";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AIProvider>(
      builder: (_, provider, __) {
        if (provider.conversations.isEmpty) {
          return const SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recent Conversations",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            ...provider.conversations
                .take(5)
                .map(
                  (conversation) => RecentChatCard(
                    title: conversation.title,
                    time: _formatTime(conversation.updatedAt),
                    onTap: () async {
                      await provider.openConversation(conversation);
                    },
                  ),
                ),
          ],
        );
      },
    );
  }
}
