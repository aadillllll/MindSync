import 'package:flutter/material.dart';

import '../widgets/calendar_header.dart';
import '../widgets/month_calendar.dart';
import '../widgets/agenda_section.dart';
import '../widgets/upcoming_deadlines.dart';
import '../widgets/ai_schedule_card.dart';
import '../widgets/add_event_button.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  void _previousMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
    });
  }

  void _selectDay(DateTime day) {
    setState(() {
      _selectedDay = day;
      _focusedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),

      floatingActionButton: AddEventButton(
        onPressed: () {
          // TODO: Add Event
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CalendarHeader(
                selectedMonth: _focusedDay,
                onPrevious: _previousMonth,
                onNext: _nextMonth,
              ),

              const SizedBox(height: 24),

              MonthCalendar(
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                onDaySelected: _selectDay,
              ),

              const SizedBox(height: 30),

              const AgendaSection(),

              const SizedBox(height: 30),

              const UpcomingDeadlines(),

              const SizedBox(height: 30),

              const AIScheduleCard(),
            ],
          ),
        ),
      ),
    );
  }
}
