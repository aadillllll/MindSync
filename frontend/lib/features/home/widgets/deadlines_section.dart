import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';

import '../models/deadline_dummy_data.dart';
import 'deadline_card.dart';

class DeadlinesSection extends StatelessWidget {
  const DeadlinesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Upcoming Deadlines",
              style: AppTextStyles.title.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text("View all")),
          ],
        ),

        const SizedBox(height: 14),

        ...deadlines.map(
          (deadline) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: DeadlineCard(
              day: deadline.day,
              month: deadline.month,
              title: deadline.title,
              subtitle: deadline.subtitle,
              priority: deadline.priority,
            ),
          ),
        ),
      ],
    );
  }
}
