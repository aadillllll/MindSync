import 'package:flutter/material.dart';

class AIWelcomeCard extends StatelessWidget {
  const AIWelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7C5CFF), Color(0xFF5D7CFF)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .18),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const SizedBox(width: 16),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Afternoon 👋",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "How can I help today?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          const Text(
            "I can help you organize your schedule, summarize notes, "
            "plan study sessions, manage deadlines, and keep you productive throughout the day.",
            style: TextStyle(color: Colors.white, height: 1.6, fontSize: 15),
          ),

          const SizedBox(height: 22),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Icon(Icons.lightbulb_outline_rounded, color: Colors.white),

                SizedBox(width: 12),

                Expanded(
                  child: Text(
                    "Tip: Ask me to create a study timetable from your upcoming exams.",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
