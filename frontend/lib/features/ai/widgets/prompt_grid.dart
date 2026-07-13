import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ai_provider.dart';
import 'quick_prompt_card.dart';

class PromptGrid extends StatelessWidget {
  const PromptGrid({super.key});

  void _sendPrompt(BuildContext context, String prompt) {
    context.read<AIProvider>().sendMessage(prompt);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Prompts",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.25,
          children: [
            QuickPromptCard(
              icon: Icons.calendar_month_rounded,
              title: "Plan My Day",
              color: Colors.deepPurpleAccent,
              onTap: () => _sendPrompt(context, "Plan my day."),
            ),

            QuickPromptCard(
              icon: Icons.menu_book_rounded,
              title: "Study Assistant",
              color: Colors.blueAccent,
              onTap: () => _sendPrompt(context, "Help me study today."),
            ),

            QuickPromptCard(
              icon: Icons.notes_rounded,
              title: "Summarize Notes",
              color: Colors.orange,
              onTap: () => _sendPrompt(context, "Summarize all my notes."),
            ),

            QuickPromptCard(
              icon: Icons.track_changes_rounded,
              title: "Goal Planner",
              color: Colors.green,
              onTap: () => _sendPrompt(
                context,
                "Review my goals and suggest the next steps.",
              ),
            ),

            QuickPromptCard(
              icon: Icons.lightbulb_outline_rounded,
              title: "Brainstorm Ideas",
              color: Colors.amber,
              onTap: () => _sendPrompt(
                context,
                "Give me personalized ideas based on my productivity data.",
              ),
            ),

            QuickPromptCard(
              icon: Icons.school_rounded,
              title: "Explain Concept",
              color: Colors.cyan,
              onTap: () =>
                  _sendPrompt(context, "Help me learn a concept step by step."),
            ),
          ],
        ),
      ],
    );
  }
}
