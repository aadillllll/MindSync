import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/glass_card.dart';

class DeadlineCard extends StatelessWidget {
  final String day;
  final String month;
  final String title;
  final String subtitle;
  final String priority;

  const DeadlineCard({
    super.key,
    required this.day,
    required this.month,
    required this.title,
    required this.subtitle,
    required this.priority,
  });

  Color get priorityColor {
    switch (priority.toLowerCase()) {
      case 'high':
        return const Color(0xffFF6B81);

      case 'medium':
        return const Color(0xffF6C453);

      case 'low':
        return const Color(0xff6BD784);

      default:
        return Colors.grey;
    }
  }

  Color get dateBackground {
    switch (priority.toLowerCase()) {
      case 'high':
        return const Color(0xff5B3BC4);

      case 'medium':
        return const Color(0xff2C65D8);

      case 'low':
        return const Color(0xff2F7A4F);

      default:
        return Colors.grey.shade800;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 68,
            decoration: BoxDecoration(
              color: dateBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  month,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.title.copyWith(fontSize: 18)),

                const SizedBox(height: 6),

                Text(subtitle, style: AppTextStyles.bodySecondary),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: priorityColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              priority,
              style: TextStyle(
                color: priorityColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
