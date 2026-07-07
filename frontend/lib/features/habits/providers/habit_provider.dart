import 'package:flutter/material.dart';

import '../models/habit_model.dart';
import '../services/habit_service.dart';

class HabitProvider extends ChangeNotifier {
  final HabitService _service = HabitService();

  List<HabitModel> _habits = [];

  bool _isLoading = false;

  List<HabitModel> get habits => _habits;

  bool get isLoading => _isLoading;

  // =========================================================
  // Load Habits
  // =========================================================

  Future<void> loadHabits() async {
    _isLoading = true;
    notifyListeners();

    try {
      _habits = await _service.getHabits();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // =========================================================
  // Create Habit
  // =========================================================

  Future<bool> createHabit(HabitModel habit) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _service.createHabit(habit);

      await loadHabits();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // =========================================================
  // Update Habit
  // =========================================================

  Future<bool> updateHabit(HabitModel habit) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _service.updateHabit(habit);

      await loadHabits();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // =========================================================
  // Delete Habit
  // =========================================================

  Future<bool> deleteHabit(String id) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _service.deleteHabit(id);

      await loadHabits();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // =========================================================
  // Complete Habit
  // =========================================================

  Future<bool> completeHabit(HabitModel habit) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _service.completeHabit(habit);

      _habits = await _service.getHabits();

      notifyListeners();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // =========================================================
  // Statistics
  // =========================================================

  // =========================================================
  // Statistics
  // =========================================================

  int get totalHabits => _habits.length;

  int get activeHabits => _habits.where((h) => !h.completedToday).length;

  int get todaysHabits {
    const weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    final today = weekDays[DateTime.now().weekday - 1];

    return _habits.where((habit) => habit.frequencyDays.contains(today)).length;
  }

  int get completedToday {
    const weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    final today = weekDays[DateTime.now().weekday - 1];

    return _habits
        .where(
          (habit) =>
              habit.frequencyDays.contains(today) && habit.completedToday,
        )
        .length;
  }

  int get pendingToday {
    return todaysHabits - completedToday;
  }

  double get completionRate {
    if (todaysHabits == 0) return 0;

    return completedToday / todaysHabits;
  }

  List<HabitModel> get completed =>
      _habits.where((h) => h.completedToday).toList();

  List<HabitModel> get pending =>
      _habits.where((h) => !h.completedToday).toList();
}
