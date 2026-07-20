import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../tasks/models/task_model.dart';
import '../models/calendar_event.dart';

class MonthCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final ValueChanged<DateTime> onDaySelected;

  /// All tasks loaded from CalendarProvider
  final List<TaskModel> tasks;

  /// All events loaded from CalendarProvider
  final List<CalendarEvent> events;

  const MonthCalendar({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.tasks,
    required this.events,
  });

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF182135),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: TableCalendar(
        firstDay: DateTime(2020),
        lastDay: DateTime(2035),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        headerVisible: false,
        calendarFormat: CalendarFormat.month,
        daysOfWeekHeight: 30,
        rowHeight: 48,

        onDaySelected: (selected, focused) {
          onDaySelected(selected);
        },

        // Used internally by TableCalendar
        eventLoader: (day) {
          final dayTasks = tasks.where((task) {
            if (task.dueDate == null) return false;
            return isSameDay(task.dueDate!, day);
          });

          final dayEvents = events.where((event) {
            return isSameDay(event.startDateTime, day);
          });

          return [...dayTasks, ...dayEvents];
        },

        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, day, _) {
            final hasTask = tasks.any(
              (task) => task.dueDate != null && isSameDay(task.dueDate!, day),
            );

            final dayEvents = events.where(
              (event) => isSameDay(event.startDateTime, day),
            );

            final hasEvent = dayEvents.isNotEmpty;

            Color? eventColor;

            if (hasEvent) {
              eventColor = _getEventColor(dayEvents.first.color);
            }

            if (!hasTask && !hasEvent) {
              return const SizedBox.shrink();
            }

            return Positioned(
              bottom: 5,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasTask)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF7C5CFF),
                        shape: BoxShape.circle,
                      ),
                    ),

                  if (hasTask && hasEvent) const SizedBox(width: 4),

                  if (hasEvent)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: eventColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            );
          },
        ),

        calendarStyle: const CalendarStyle(
          outsideDaysVisible: false,

          defaultTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),

          weekendTextStyle: TextStyle(color: Colors.white),

          todayDecoration: BoxDecoration(
            color: Color(0xFF3D4A63),
            shape: BoxShape.circle,
          ),

          selectedDecoration: BoxDecoration(
            color: Color(0xFF7C5CFF),
            shape: BoxShape.circle,
          ),

          todayTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),

          selectedTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),

          markersMaxCount: 2,

          markerDecoration: BoxDecoration(
            color: Color(0xFF7C5CFF),
            shape: BoxShape.circle,
          ),
        ),

        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
          weekendStyle: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
