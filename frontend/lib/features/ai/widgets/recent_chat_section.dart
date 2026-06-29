import 'package:flutter/material.dart';

import 'recent_chat_card.dart';

class RecentChatSection extends StatelessWidget {
  const RecentChatSection({super.key});

  @override
  Widget build(BuildContext context) {
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

        RecentChatCard(
          title: "Study Timetable",
          subtitle: "Created a weekly study schedule for your exams.",
          time: "10 min",
          icon: Icons.calendar_month_rounded,
          color: Colors.deepPurpleAccent,
        ),

        RecentChatCard(
          title: "Summarize Notes",
          subtitle: "Summarized your Operating Systems notes.",
          time: "Yesterday",
          icon: Icons.notes_rounded,
          color: Colors.orange,
        ),

        RecentChatCard(
          title: "Assignment Planner",
          subtitle: "Generated a deadline-based work plan.",
          time: "2 days",
          icon: Icons.assignment_rounded,
          color: Colors.green,
        ),
      ],
    );
  }
}
