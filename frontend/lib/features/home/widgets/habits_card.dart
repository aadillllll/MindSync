import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/glass_card.dart';
import '../../../core/theme/app_text_styles.dart';
import 'home_habit_row.dart';
import '../../habits/screens/habits_screen.dart';
import '../../habits/screens/habit_details_screen.dart';
import '../providers/dashboard_provider.dart';
import 'home_habit_item.dart';

class HabitsCard extends StatelessWidget {
  const HabitsCard({super.key});

  Color _colorFromHex(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xff')));
    } catch (_) {
      return Colors.blue;
    }
  }

  IconData _iconFromString(String icon) {
    switch (icon) {
      case 'water_drop':
        return Icons.water_drop_rounded;
      case 'fitness_center':
        return Icons.fitness_center_rounded;
      case 'menu_book':
        return Icons.menu_book_rounded;
      case 'self_improvement':
        return Icons.self_improvement_rounded;
      default:
        return Icons.check_circle_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = context.watch<DashboardProvider>().dashboard;
    final habits = (dashboard?.todayHabits ?? []).take(4).toList();

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

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HabitsScreen()),
                  );
                },
                child: const Text("View all"),
              ),
            ],
          ),

          const SizedBox(height: 26),

          if (habits.isEmpty)
            SizedBox(
              height: 120,
              child: Center(
                child: Text(
                  "No habits created yet.",
                  style: AppTextStyles.bodySecondary,
                ),
              ),
            )
          else
            Column(
              children: List.generate(habits.length, (index) {
                final habit = habits[index];

                return Column(
                  children: [
                    HomeHabitRow(
                      title: habit.title,
                      icon: _iconFromString(habit.icon),
                      color: _colorFromHex(habit.color),
                      streak: habit.currentStreak,
                      completed: habit.completedToday,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HabitDetailsScreen(habit: habit),
                          ),
                        );
                      },
                    ),

                    if (index != habits.length - 1)
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                  ],
                );
              }),
            ),
        ],
      ),
    );
  }
}
