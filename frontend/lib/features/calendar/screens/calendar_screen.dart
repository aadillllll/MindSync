import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calendar_provider.dart';
import '../widgets/add_event_button.dart';
import '../widgets/agenda_section.dart';
import '../widgets/ai_schedule_card.dart';
import '../widgets/calendar_header.dart';
import '../widgets/month_calendar.dart';
import '../widgets/upcoming_deadlines.dart';
import '../../tasks/screens/create_task_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CalendarProvider>().loadCalendar();
      context.read<CalendarProvider>().selectDay(_selectedDay);
    });
  }

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

    context.read<CalendarProvider>().selectDay(day);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalendarProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),

      floatingActionButton: AddEventButton(
        onPressed: () async {
          final created = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateTaskScreen(initialDueDate: _selectedDay),
            ),
          );

          if (!mounted) return;

          if (created == true) {
            await context.read<CalendarProvider>().loadCalendar();
          }
        },
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
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
                      tasks: provider.allTasks,
                    ),

                    const SizedBox(height: 30),

                    AgendaSection(selectedDay: _selectedDay),

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
