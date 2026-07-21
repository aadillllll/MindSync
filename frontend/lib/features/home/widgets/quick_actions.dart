import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';

import '../../goals/screens/goals_screen.dart';
import '../../habits/screens/habits_screen.dart';
import '../../notes/screens/notes_screen.dart';
import '../../tasks/screens/task_screen.dart';

import '../models/quick_action_dummy_data.dart';
import 'quick_action_card.dart';

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

      case "Notes":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NotesScreen()),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final compact = width < 390;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quick Actions",
              style: AppTextStyles.title.copyWith(
                fontSize: compact ? 20 : 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: compact ? 14 : 18),

            if (!compact)
              Row(
                children: List.generate(quickActions.length, (index) {
                  final action = quickActions[index];

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 0 : 4,
                        right: index == quickActions.length - 1 ? 0 : 4,
                      ),
                      child: QuickActionCard(
                        title: action.title,
                        icon: action.icon,
                        gradient: action.gradient,
                        onTap: () => _handleTap(context, action.title),
                      ),
                    ),
                  );
                }),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quickActions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.18,
                ),
                itemBuilder: (context, index) {
                  final action = quickActions[index];

                  return QuickActionCard(
                    title: action.title,
                    icon: action.icon,
                    gradient: action.gradient,
                    onTap: () => _handleTap(context, action.title),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
