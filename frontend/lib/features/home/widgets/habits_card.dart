import 'package:flutter/material.dart';

import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/progress_ring.dart';
import '../../../core/theme/app_text_styles.dart';

import '../models/habit_dummy_data.dart';

class HabitsCard extends StatelessWidget {
  const HabitsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_fire_department_outlined,
                color: Colors.white70,
                size: 22,
              ),

              const SizedBox(width: 10),

              Text("Habits", style: AppTextStyles.title),

              const Spacer(),

              TextButton(onPressed: () {}, child: const Text("View all")),
            ],
          ),

          const SizedBox(height: 26),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: habits.map((habit) {
              return Column(
                children: [
                  ProgressRing(
                    progress: habit.progress,
                    color: habit.color,
                    percentage: habit.percentage,
                    icon: habit.icon,
                  ),

                  const SizedBox(height: 14),

                  Text(habit.title, style: AppTextStyles.body),

                  const SizedBox(height: 4),

                  Text(habit.subtitle, style: AppTextStyles.bodySecondary),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
