import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/calendar_provider.dart';
import '../models/calendar_event.dart';
import '../screens/event_details_screen.dart';
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

  Color _getEventColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;

      case 'green':
        return Colors.green;

      case 'blue':
        return Colors.blue;

      case 'orange':
        return Colors.orange;

      case 'purple':
        return Colors.purple;

      case 'pink':
        return Colors.pink;

      case 'teal':
        return Colors.teal;

      case 'indigo':
        return Colors.indigo;

      default:
        return const Color(0xFF7C5CFF);
    }
  }

  String _formatEventTime(CalendarEvent event) {
    if (event.isAllDay) {
      return "All Day";
    }

    final formatter = DateFormat('hh:mm a');

    return "${formatter.format(event.startDateTime)} - ${formatter.format(event.endDateTime)}";
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalendarProvider>();

    final events = provider.selectedDayEvents;
    final tasks = provider.selectedDayTasks;

    final isEmpty = events.isEmpty && tasks.isEmpty;

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

        if (isEmpty)
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
                "Nothing scheduled for this day 🎉",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          )
        else ...[
          // =====================================================
          // EVENTS
          // =====================================================
          if (events.isNotEmpty) ...[
            const Text(
              "Events",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            ...events.map(
              (event) => GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EventDetailsScreen(event: event),
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
                  title: event.title,
                  time: _formatEventTime(event),
                  location: (event.location?.trim().isNotEmpty ?? false)
                      ? event.location!
                      : ((event.description?.trim().isNotEmpty ?? false)
                            ? event.description!
                            : "No description"),
                  color: _getEventColor(event.color),
                ),
              ),
            ),
          ],

          if (events.isNotEmpty && tasks.isNotEmpty) const SizedBox(height: 20),

          // =====================================================
          // TASKS
          // =====================================================
          if (tasks.isNotEmpty) ...[
            const Text(
              "Tasks",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

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
                  time: task.priority?.toString() ?? "No Priority",
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
        ],
      ],
    );
  }
}
