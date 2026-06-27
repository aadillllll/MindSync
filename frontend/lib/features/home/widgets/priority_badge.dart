import 'package:flutter/material.dart';

class PriorityBadge extends StatelessWidget {
  final String priority;

  const PriorityBadge({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (priority.toLowerCase()) {
      case "high":
        bgColor = const Color(0xFF4A2432);
        textColor = const Color(0xFFFF7A9C);
        break;

      case "medium":
        bgColor = const Color(0xFF4A3E20);
        textColor = const Color(0xFFFFC857);
        break;

      default:
        bgColor = const Color(0xFF1D4231);
        textColor = const Color(0xFF7EE787);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
