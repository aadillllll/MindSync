import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../tasks/models/task_model.dart';
import '../../tasks/screens/task_details_screen.dart';
import '../providers/dashboard_provider.dart';
import 'focus_task_tile.dart';
import '../../tasks/screens/task_screen.dart';

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
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        final dashboard = provider.dashboard;
        final List<TaskModel> tasks = dashboard?.todayTasks ?? [];

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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const TasksScreen(filter: TaskFilter.today),
                      ),
                    );
                  },
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

            /// Loading State
            if (provider.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(child: CircularProgressIndicator()),
              )
            /// Empty State
            else if (tasks.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.task_alt_rounded,
                      size: 42,
                      color: Colors.white.withValues(alpha: .55),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "No tasks scheduled for today",
                      style: AppTextStyles.body.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              )
            /// Tasks
            else
              ...List.generate(tasks.length, (index) {
                final task = tasks[index];

                String dueText = "No Due Date";

                if (task.dueDate != null) {
                  final now = DateTime.now();

                  final due = task.dueDate!;

                  if (due.year == now.year &&
                      due.month == now.month &&
                      due.day == now.day) {
                    dueText = "Due ${DateFormat('h:mm a').format(due)}";
                  } else {
                    dueText = "Due ${DateFormat('dd MMM, h:mm a').format(due)}";
                  }
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () async {
                      final updated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TaskDetailsScreen(task: task),
                        ),
                      );

                      if (updated == true && context.mounted) {
                        await context.read<DashboardProvider>().refresh();
                      }
                    },
                    child: FocusTaskTile(
                      number: index + 1,
                      title: task.title,
                      priority: task.priority ?? "Low",
                      dueTime: dueText,
                      numberColor: _getNumberColor(task.priority ?? "Low"),
                    ),
                  ),
                );
              }),
          ],
        );
      },
    );
  }
}
