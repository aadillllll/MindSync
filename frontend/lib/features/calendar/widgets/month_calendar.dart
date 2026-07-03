import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../tasks/models/task_model.dart';

class MonthCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final ValueChanged<DateTime> onDaySelected;

  /// All tasks loaded from CalendarProvider
  final List<TaskModel> tasks;

  const MonthCalendar({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.tasks,
  });

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

        // --------------------------------------------------
        // TASK MARKERS
        // --------------------------------------------------
        eventLoader: (day) {
          return tasks.where((task) {
            if (task.dueDate == null) return false;

            return isSameDay(task.dueDate!, day);
          }).toList();
        },

        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, day, events) {
            if (events.isEmpty) return const SizedBox.shrink();

            return Positioned(
              bottom: 6,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF7C5CFF),
                  shape: BoxShape.circle,
                ),
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

          markersMaxCount: 1,

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
