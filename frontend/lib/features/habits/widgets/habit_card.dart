import 'package:flutter/material.dart';

import '../models/habit_model.dart';

class HabitCard extends StatelessWidget {
  final HabitModel habit;
  final VoidCallback? onTap;
  final VoidCallback? onComplete;

  const HabitCard({
    super.key,
    required this.habit,
    this.onTap,
    this.onComplete,
  });

  static const List<String> weekDays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

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

  Color _colorFromHex(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xff')));
    } catch (_) {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorFromHex(habit.color);

    const weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    final todayName = weekDays[DateTime.now().weekday - 1];

    final isScheduledToday = habit.frequencyDays.contains(todayName);

    final canComplete = isScheduledToday && !habit.completedToday;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: habit.completedToday
                        ? Colors.green.withValues(alpha: 0.12)
                        : color.withValues(alpha: 0.12),
                    child: Icon(
                      habit.completedToday
                          ? Icons.check_circle
                          : _iconFromString(habit.icon),
                      color: habit.completedToday ? Colors.green : color,
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Text(
                      habit.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: onTap,
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    color: Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${habit.currentStreak} Day Streak",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: weekDays.map((day) {
                  final selected = habit.frequencyDays.contains(day);

                  return Column(
                    children: [
                      Text(
                        day.substring(0, 1),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: selected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selected ? color : Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selected
                              ? color
                              : Colors.grey.withValues(alpha: 0.25),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: canComplete ? onComplete : null,

                    icon: Icon(
                      habit.completedToday ? Icons.check_circle : Icons.check,
                    ),

                    label: Text(
                      habit.completedToday
                          ? "Completed Today"
                          : !isScheduledToday
                          ? "Not Scheduled Today"
                          : "Complete",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
