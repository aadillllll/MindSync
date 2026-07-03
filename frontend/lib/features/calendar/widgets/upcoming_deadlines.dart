import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/calendar_provider.dart';
import '../../tasks/screens/task_details_screen.dart';

class UpcomingDeadlines extends StatelessWidget {
  const UpcomingDeadlines({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalendarProvider>();

    final tasks = provider.upcomingTasks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Upcoming Deadlines",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        if (tasks.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFF182135),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white10),
            ),
            child: const Center(
              child: Text(
                "No upcoming deadlines 🎉",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ),
          )
        else
          ...tasks.map((task) {
            Color color;

            switch ((task.priority ?? "").toLowerCase()) {
              case "high":
                color = Colors.redAccent;
                break;
              case "medium":
                color = Colors.orange;
                break;
              default:
                color = Colors.green;
            }

            final due = task.dueDate != null
                ? DateFormat("dd MMM").format(task.dueDate!)
                : "No Date";

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

                  if (!context.mounted) return;

                  if (updated == true) {
                    await context.read<CalendarProvider>().loadCalendar();
                    context.read<CalendarProvider>().selectDay(
                      provider.selectedDay,
                    );
                  }
                },
                child: _deadlineCard(
                  title: task.title,
                  due: due,
                  priority: task.priority ?? "Low",
                  color: color,
                ),
              ),
            );
          }),
      ],
    );
  }

  Widget _deadlineCard({
    required String title,
    required String due,
    required String priority,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF182135),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "Due: $due",
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              priority,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
