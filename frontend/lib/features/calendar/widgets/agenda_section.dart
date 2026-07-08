import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/calendar_provider.dart';
import 'event_card.dart';
import '../../tasks/screens/task_details_screen.dart';

class AgendaSection extends StatelessWidget {
  final DateTime selectedDay;

  const AgendaSection({super.key, required this.selectedDay});

  String _getAgendaTitle() {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
    );

    final difference = selected.difference(today).inDays;

    if (difference == 0) {
      return "Today's Agenda";
    }

    if (difference == 1) {
      return "Tomorrow's Agenda";
    }

    if (difference == -1) {
      return "Yesterday's Agenda";
    }

    return "Agenda • ${DateFormat('dd MMM yyyy').format(selectedDay)}";
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalendarProvider>();
    final tasks = provider.selectedDayTasks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getAgendaTitle(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        if (tasks.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF182135),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: const Center(
              child: Text(
                "No tasks for this day 🎉",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          )
        else
          ...tasks.map(
            (task) => GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TaskDetailsScreen(task: task),
                  ),
                );

                if (context.mounted) {
                  await context.read<CalendarProvider>().loadCalendar();
                  context.read<CalendarProvider>().selectDay(
                    provider.selectedDay,
                  );
                }
              },
              child: EventCard(
                title: task.title,
                time: task.priority ?? "No Priority",
                location: task.description?.isNotEmpty == true
                    ? task.description!
                    : "No description",
                color: task.isCompleted
                    ? Colors.green
                    : const Color(0xFF7C5CFF),
                isCompleted: task.isCompleted,
              ),
            ),
          ),
      ],
    );
  }
}
