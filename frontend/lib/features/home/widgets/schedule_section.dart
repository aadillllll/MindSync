import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/glass_card.dart';

import '../models/schedule_dummy_data.dart';
import 'schedule_card.dart';

class ScheduleSection extends StatelessWidget {
  const ScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Today's Schedule",
                style: AppTextStyles.title.copyWith(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              TextButton(onPressed: () {}, child: const Text("View all")),
            ],
          ),

          const SizedBox(height: 20),

          ...List.generate(schedules.length, (index) {
            final item = schedules[index];

            return ScheduleCard(
              time: item.time,
              title: item.title,
              subtitle: item.subtitle,
              color: Color(item.color),
              isLast: index == schedules.length - 1,
            );
          }),
        ],
      ),
    );
  }
}
