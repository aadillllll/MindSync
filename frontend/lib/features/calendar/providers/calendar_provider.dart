import 'package:flutter/material.dart';

import '../../tasks/models/task_model.dart';
import '../../tasks/services/task_service.dart';

import '../models/calendar_event.dart';
import '../services/calendar_service.dart';

class CalendarProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  final CalendarService _calendarService = CalendarService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<TaskModel> _tasks = [];
  List<CalendarEvent> _events = [];

  List<TaskModel> get allTasks => _tasks;
  List<CalendarEvent> get allEvents => _events;

  DateTime _selectedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;

  void selectDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  // =========================================================
  // Load Calendar Data
  // =========================================================

  Future<void> loadCalendar() async {
    _isLoading = true;
    notifyListeners();

    try {
      final results = await Future.wait([
        _taskService.getTasks(),
        _calendarService.getEvents(),
      ]);

      _tasks = results[0] as List<TaskModel>;
      _events = results[1] as List<CalendarEvent>;
    } catch (e) {
      debugPrint('Calendar Load Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // =========================================================
  // TASKS
  // =========================================================

  List<TaskModel> get todayTasks {
    return _tasks.where((task) {
      if (task.dueDate == null) return false;

      final now = DateTime.now();

      return task.dueDate!.year == now.year &&
          task.dueDate!.month == now.month &&
          task.dueDate!.day == now.day;
    }).toList();
  }

  List<TaskModel> get selectedDayTasks {
    return _tasks.where((task) {
      if (task.dueDate == null) return false;

      return task.dueDate!.year == _selectedDay.year &&
          task.dueDate!.month == _selectedDay.month &&
          task.dueDate!.day == _selectedDay.day;
    }).toList();
  }

  List<TaskModel> get upcomingTasks {
    final now = DateTime.now();

    final list = _tasks.where((task) {
      if (task.dueDate == null) return false;

      return task.dueDate!.isAfter(now);
    }).toList();

    list.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

    return list.take(5).toList();
  }

  // =========================================================
  // EVENTS
  // =========================================================

  List<CalendarEvent> get todayEvents {
    final now = DateTime.now();

    return _events.where((event) {
      return event.startDateTime.year == now.year &&
          event.startDateTime.month == now.month &&
          event.startDateTime.day == now.day;
    }).toList()..sort((a, b) => a.startDateTime.compareTo(b.startDateTime));
  }

  List<CalendarEvent> get selectedDayEvents {
    return _events.where((event) {
      return event.startDateTime.year == _selectedDay.year &&
          event.startDateTime.month == _selectedDay.month &&
          event.startDateTime.day == _selectedDay.day;
    }).toList()..sort((a, b) => a.startDateTime.compareTo(b.startDateTime));
  }

  List<CalendarEvent> get upcomingEvents {
    final now = DateTime.now();

    final list = _events
        .where((event) => event.startDateTime.isAfter(now))
        .toList();

    list.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));

    return list.take(5).toList();
  }

  // =========================================================
  // Event Helpers
  // =========================================================

  bool hasEvents(DateTime day) {
    return _events.any(
      (event) =>
          event.startDateTime.year == day.year &&
          event.startDateTime.month == day.month &&
          event.startDateTime.day == day.day,
    );
  }

  int eventCount(DateTime day) {
    return _events
        .where(
          (event) =>
              event.startDateTime.year == day.year &&
              event.startDateTime.month == day.month &&
              event.startDateTime.day == day.day,
        )
        .length;
  }

  List<CalendarEvent> eventsForDate(DateTime day) {
    final list = _events
        .where(
          (event) =>
              event.startDateTime.year == day.year &&
              event.startDateTime.month == day.month &&
              event.startDateTime.day == day.day,
        )
        .toList();

    list.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));

    return list;
  }

  // =========================================================
  // Event CRUD
  // =========================================================

  Future<bool> createEvent(CalendarEvent event) async {
    try {
      await _calendarService.createEvent(event);
      await loadCalendar();
      return true;
    } catch (e) {
      debugPrint('Create Event Error: $e');
      return false;
    }
  }

  Future<bool> updateEvent(CalendarEvent event) async {
    try {
      await _calendarService.updateEvent(event);
      await loadCalendar();
      return true;
    } catch (e) {
      debugPrint('Update Event Error: $e');
      return false;
    }
  }

  Future<bool> deleteEvent(String eventId) async {
    try {
      await _calendarService.deleteEvent(eventId);
      await loadCalendar();
      return true;
    } catch (e) {
      debugPrint('Delete Event Error: $e');
      return false;
    }
  }

  Future<void> refresh() async {
    await loadCalendar();
  }
}
