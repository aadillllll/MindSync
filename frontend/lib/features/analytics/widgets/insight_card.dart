import 'package:flutter/material.dart';

class InsightCard extends StatelessWidget {
  const InsightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF7C5CFF).withValues(alpha: .12),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        children: [
          Icon(Icons.auto_awesome_rounded, color: Color(0xFF7C5CFF), size: 30),

          SizedBox(width: 18),

          Expanded(
            child: Text(
              "Excellent! You're more productive than 89% of your previous weeks.",
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
