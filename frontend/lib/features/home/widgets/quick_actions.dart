import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';

import '../../tasks/screens/create_task_screen.dart';
import '../../tasks/screens/task_screen.dart';

import '../models/quick_action_dummy_data.dart';
import 'quick_action_card.dart';
import '../../goals/screens/goals_screen.dart';
import '../../habits/screens/habits_screen.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  void _handleTap(BuildContext context, String title) {
    switch (title) {
      case "Habits":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HabitsScreen()),
        );
        break;

      case "My Tasks":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TasksScreen()),
        );
        break;

      case "Add Note":
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Notes module coming soon")),
        );
        break;

      case "Goals":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const GoalsScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: AppTextStyles.title.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        Row(
          children: quickActions
              .map(
                (action) => QuickActionCard(
                  title: action.title,
                  icon: action.icon,
                  gradient: action.gradient,
                  onTap: () => _handleTap(context, action.title),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
