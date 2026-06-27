import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';

import '../models/focus_dummy_data.dart';
import 'focus_task_tile.dart';

class FocusSection extends StatelessWidget {
  const FocusSection({super.key});

  Color _getNumberColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return const Color(0xff8D63FF);

      case 'medium':
        return const Color(0xff57A4FF);

      case 'low':
        return const Color(0xff7EE787);

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Today's Focus",
              style: AppTextStyles.title.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            TextButton(
              onPressed: () {},
              child: const Text(
                "View all",
                style: TextStyle(
                  color: Color(0xff6F8BFF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        ...focusTasks.map(
          (task) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FocusTaskTile(
              number: task.number,
              title: task.title,
              priority: task.priority,
              dueTime: task.dueTime,
              numberColor: _getNumberColor(task.priority),
            ),
          ),
        ),
      ],
    );
  }
}
