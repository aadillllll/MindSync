import 'package:flutter/material.dart';

import 'quick_prompt_card.dart';

class PromptGrid extends StatelessWidget {
  const PromptGrid({super.key});

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
              onTap: () {},
            ),

            QuickPromptCard(
              icon: Icons.menu_book_rounded,
              title: "Study Assistant",
              color: Colors.blueAccent,
              onTap: () {},
            ),

            QuickPromptCard(
              icon: Icons.notes_rounded,
              title: "Summarize Notes",
              color: Colors.orange,
              onTap: () {},
            ),

            QuickPromptCard(
              icon: Icons.track_changes_rounded,
              title: "Goal Planner",
              color: Colors.green,
              onTap: () {},
            ),

            QuickPromptCard(
              icon: Icons.lightbulb_outline_rounded,
              title: "Brainstorm Ideas",
              color: Colors.amber,
              onTap: () {},
            ),

            QuickPromptCard(
              icon: Icons.school_rounded,
              title: "Explain Concept",
              color: Colors.cyan,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
