import 'package:flutter/material.dart';

class AIInsightCard extends StatelessWidget {
  const AIInsightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7C5CFF), Color(0xFF5D7CFF)],
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome_rounded, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "AI Insight",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),

          SizedBox(height: 18),

          Text(
            "Your productivity is highest between 7:00 PM and 9:00 PM.\n\n"
            "Try scheduling your most difficult study sessions during this period. "
            "You've also maintained an 18-day habit streak—keep it going!",
            style: TextStyle(color: Colors.white, fontSize: 15, height: 1.6),
          ),
        ],
      ),
    );
  }
}
