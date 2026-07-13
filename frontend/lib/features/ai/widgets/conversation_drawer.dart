import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ai_provider.dart';

class ConversationDrawer extends StatelessWidget {
  const ConversationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0B1120),
      child: SafeArea(
        child: Consumer<AIProvider>(
          builder: (_, provider, __) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await provider.newConversation();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("New Chat"),
                    ),
                  ),
                ),

                const Divider(color: Colors.white24),

                Expanded(
                  child: ListView.builder(
                    itemCount: provider.conversations.length,
                    itemBuilder: (_, index) {
                      final conversation = provider.conversations[index];

                      return ListTile(
                        leading: const Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.white70,
                        ),
                        title: Text(
                          conversation.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          conversation.updatedAt.toString(),
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                        onTap: () async {
                          await provider.openConversation(conversation);

                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
