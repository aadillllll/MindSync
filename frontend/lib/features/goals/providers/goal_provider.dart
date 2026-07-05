import 'package:flutter/material.dart';

import '../models/goal_model.dart';
import '../services/goal_service.dart';

class GoalProvider extends ChangeNotifier {
  final GoalService _service = GoalService();

  List<GoalModel> _goals = [];

  bool _isLoading = false;

  List<GoalModel> get goals => _goals;

  bool get isLoading => _isLoading;

  // =========================================================
  // Load Goals
  // =========================================================

  Future<void> loadGoals() async {
    _isLoading = true;
    notifyListeners();

    try {
      _goals = await _service.getGoals();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // =========================================================
  // Create Goal
  // =========================================================

  Future<bool> createGoal(GoalModel goal) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _service.createGoal(goal);

      await loadGoals();

      return true;
    } catch (_) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // =========================================================
  // Update Goal
  // =========================================================

  Future<bool> updateGoal(GoalModel goal) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _service.updateGoal(goal);

      await loadGoals();

      return true;
    } catch (_) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // =========================================================
  // Delete Goal
  // =========================================================

  Future<bool> deleteGoal(String id) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _service.deleteGoal(id);

      await loadGoals();

      return true;
    } catch (_) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // =========================================================
  // Complete Goal
  // =========================================================

  Future<bool> completeGoal(String id) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _service.completeGoal(id);

      await loadGoals();

      return true;
    } catch (_) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // =========================================================
  // Update Progress
  // =========================================================

  Future<bool> updateProgress(String goalId, int progress) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _service.updateProgress(goalId, progress);

      await loadGoals();

      return true;
    } catch (_) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // =========================================================
  // Statistics
  // =========================================================

  int get totalGoals => _goals.length;

  int get completedGoals => _goals.where((goal) => goal.completed).length;

  int get activeGoals => _goals.where((goal) => !goal.completed).length;

  double get completionRate {
    if (_goals.isEmpty) return 0;
    return completedGoals / _goals.length;
  }

  // =========================================================
  // Helper Lists
  // =========================================================

  List<GoalModel> get completed =>
      _goals.where((goal) => goal.completed).toList();

  List<GoalModel> get active =>
      _goals.where((goal) => !goal.completed).toList();

  List<GoalModel> get overdue => _goals.where((goal) {
    return !goal.completed &&
        goal.deadline != null &&
        goal.deadline!.isBefore(DateTime.now());
  }).toList();
}
