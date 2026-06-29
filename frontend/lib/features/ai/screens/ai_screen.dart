import 'package:flutter/material.dart';

import '../widgets/ai_header.dart';
import '../widgets/ai_welcome_card.dart';
import '../widgets/prompt_grid.dart';
import '../widgets/recent_chat_section.dart';
import '../widgets/chat_input_bar.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AIHeader(),

                    SizedBox(height: 24),

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

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: const ChatInputBar(),
            ),
          ],
        ),
      ),
    );
  }
}
