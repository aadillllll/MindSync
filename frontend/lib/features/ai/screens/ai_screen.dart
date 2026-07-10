import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ai_provider.dart';
import '../widgets/ai_header.dart';
import '../widgets/ai_welcome_card.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/message_bubble.dart';
import '../widgets/prompt_grid.dart';
import '../widgets/recent_chat_section.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AIProvider>(
      builder: (_, provider, __) {
        final hasMessages = provider.messages.isNotEmpty;

        return Scaffold(
          backgroundColor: const Color(0xFF0B1120),

          body: SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: AIHeader(),
                ),

                Expanded(
                  child: hasMessages
                      ? ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount:
                              provider.messages.length +
                              (provider.loading ? 1 : 0),
                          itemBuilder: (_, index) {
                            if (provider.loading &&
                                index == provider.messages.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            return MessageBubble(
                              message: provider.messages[index],
                            );
                          },
                        )
                      : const SingleChildScrollView(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),

                              AIWelcomeCard(),

                              SizedBox(height: 30),

                              PromptGrid(),

                              SizedBox(height: 30),

                              RecentChatSection(),

                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                ),

                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: ChatInputBar(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
