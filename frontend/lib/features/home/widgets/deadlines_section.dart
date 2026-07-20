import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../tasks/models/task_model.dart';
import '../../tasks/screens/task_details_screen.dart';
import '../../tasks/screens/task_screen.dart';
import '../providers/dashboard_provider.dart';
import 'deadline_card.dart';

class DeadlinesSection extends StatelessWidget {
  const DeadlinesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        final dashboard = provider.dashboard;
        final List<TaskModel> deadlines = dashboard?.upcomingDeadlines ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
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
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const TasksScreen(filter: TaskFilter.upcoming),
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

            /// Loading
            if (provider.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(child: CircularProgressIndicator()),
              )
            /// Empty State
            else if (deadlines.isEmpty)
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
                      Icons.event_busy_rounded,
                      size: 42,
                      color: Colors.white.withValues(alpha: .55),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "No upcoming deadlines",
                      style: AppTextStyles.body.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              )
            /// Deadlines
            else
              ...deadlines.map((task) {
                final due = task.dueDate!;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
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
                    child: DeadlineCard(
                      day: DateFormat('dd').format(due),
                      month: DateFormat('MMM').format(due),
                      title: task.title,
                      subtitle:
                          "Due ${DateFormat('dd MMM, h:mm a').format(due)}",
                      priority: task.priority ?? "Low",
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
