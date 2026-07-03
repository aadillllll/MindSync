import 'package:flutter/material.dart';

import '../../tasks/models/task_model.dart';
import '../../tasks/services/task_service.dart';

class CalendarProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<TaskModel> _tasks = [];

  List<TaskModel> get allTasks => _tasks;

  DateTime _selectedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;

  void selectDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  Future<void> loadCalendar() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await _taskService.getTasks();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<TaskModel> get todayTasks {
    return _tasks.where((task) {
      if (task.dueDate == null) return false;

      return task.dueDate!.year == DateTime.now().year &&
          task.dueDate!.month == DateTime.now().month &&
          task.dueDate!.day == DateTime.now().day;
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
}
