import 'package:flutter/material.dart';

import '../../../core/widgets/glass_card.dart';
import '../../../core/theme/app_text_styles.dart';
import 'priority_badge.dart';

class FocusTaskTile extends StatelessWidget {
  final int number;
  final String title;
  final String priority;
  final String dueTime;
  final Color numberColor;

  const FocusTaskTile({
    super.key,
    required this.number,
    required this.title,
    required this.priority,
    required this.dueTime,
    required this.numberColor,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          /// Number Circle
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: numberColor,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          /// Task Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    PriorityBadge(priority: priority),
                  ],
                ),

                const SizedBox(height: 8),

                Text(dueTime, style: AppTextStyles.bodySecondary),
              ],
            ),
          ),

          const SizedBox(width: 16),

          /// Completion Circle
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white38, width: 2),
            ),
          ),
        ],
      ),
    );
  }
}
