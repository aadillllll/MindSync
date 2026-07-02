import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();

  List<TaskModel> _tasks = [];
  bool _isLoading = false;

  List<TaskModel> get tasks => _tasks;

  bool get isLoading => _isLoading;

  // =========================================================
  // Load Tasks
  // =========================================================

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await _taskService.getTasks();
      _tasks.sort((a, b) {
        // Pending tasks first
        if (a.completed != b.completed) {
          return a.completed ? 1 : -1;
        }

        final priorityOrder = {'high': 0, 'medium': 1, 'low': 2};

        final aPriority = priorityOrder[(a.priority ?? '').toLowerCase()] ?? 3;
        final bPriority = priorityOrder[(b.priority ?? '').toLowerCase()] ?? 3;

        return aPriority.compareTo(bPriority);
      });
    } catch (e) {
      debugPrint("TaskProvider Load Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // =========================================================
  // Create Task
  // =========================================================

  Future<bool> createTask(TaskModel task) async {
    try {
      await _taskService.createTask(task);

      await loadTasks();

      return true;
    } catch (e) {
      debugPrint("Create Task Error: $e");
      return false;
    }
  }

  // =========================================================
  // Update Task
  // =========================================================

  Future<bool> updateTask(TaskModel task) async {
    try {
      await _taskService.updateTask(task);

      await loadTasks();

      return true;
    } catch (e) {
      debugPrint("Update Task Error: $e");
      return false;
    }
  }

  Future<bool> markTaskCompleted(String taskId) async {
    try {
      await _taskService.markTaskCompleted(taskId);

      await loadTasks();

      return true;
    } catch (e) {
      debugPrint("Mark Completed Error: $e");
      return false;
    }
  }

  // =========================================================
  // Delete Task
  // =========================================================

  Future<bool> deleteTask(String taskId) async {
    try {
      await _taskService.deleteTask(taskId);

      _tasks.removeWhere((task) => task.id == taskId);

      notifyListeners();

      return true;
    } catch (e) {
      debugPrint("Delete Task Error: $e");
      return false;
    }
  }

  // =========================================================
  // Refresh
  // =========================================================

  Future<void> refresh() async {
    await loadTasks();
  }

  // =========================================================
  // Helper Getters
  // =========================================================

  List<TaskModel> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();

  List<TaskModel> get pendingTasks =>
      _tasks.where((task) => task.isPending).toList();

  List<TaskModel> get highPriorityTasks =>
      _tasks.where((task) => task.isHighPriority).toList();

  int get totalTasks => _tasks.length;

  int get completedCount => completedTasks.length;

  int get pendingCount => pendingTasks.length;
}
