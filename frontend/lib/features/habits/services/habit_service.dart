import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/habit_model.dart';

class HabitService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // ==========================================================
  // Get All Habits
  // ==========================================================

  Future<List<HabitModel>> getHabits() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return [];

    final today = DateTime.now();

    final todayString =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    final habitsResponse = await _supabase
        .from('habits')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    final logsResponse = await _supabase
        .from('habit_logs')
        .select('habit_id')
        .eq('user_id', user.id)
        .eq('completed_date', todayString);

    final completedIds = (logsResponse as List)
        .map((e) => e['habit_id'].toString())
        .toSet();

    return (habitsResponse as List).map((habit) {
      final completed = completedIds.contains(habit['id'].toString());

      print("${habit['title']} -> $completed");

      return HabitModel.fromMap({...habit, 'completed_today': completed});
    }).toList();
  }
  // ==========================================================
  // Get Single Habit
  // ==========================================================

  Future<HabitModel?> getHabit(String id) async {
    final response = await _supabase
        .from('habits')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;

    return HabitModel.fromMap(response);
  }

  // ==========================================================
  // Create Habit
  // ==========================================================

  Future<void> createHabit(HabitModel habit) async {
    await _supabase.from('habits').insert(habit.toInsertMap());
  }

  // ==========================================================
  // Update Habit
  // ==========================================================

  Future<void> updateHabit(HabitModel habit) async {
    await _supabase
        .from('habits')
        .update({
          'title': habit.title,
          'description': habit.description,
          'icon': habit.icon,
          'color': habit.color,
          'frequency_days': habit.frequencyDays,
          'current_streak': habit.currentStreak,
          'longest_streak': habit.longestStreak,
          'is_active': habit.isActive,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', habit.id);
  }

  // ==========================================================
  // Delete Habit
  // ==========================================================

  Future<void> deleteHabit(String id) async {
    await _supabase.from('habits').delete().eq('id', id);
  }

  // ==========================================================
  // Complete Habit For Today
  // ==========================================================

  Future<void> completeHabit(HabitModel habit) async {
    final user = _supabase.auth.currentUser;

    if (user == null) return;

    final today = DateTime.now();

    const weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    final todayName = weekDays[today.weekday - 1];

    if (!habit.frequencyDays.contains(todayName)) {
      return;
    }

    final todayString =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    // Check if already completed today
    final existing = await _supabase
        .from('habit_logs')
        .select()
        .eq('habit_id', habit.id)
        .eq('completed_date', todayString);

    if ((existing as List).isNotEmpty) {
      return;
    }

    // Insert today's completion
    await _supabase.from('habit_logs').insert({
      'habit_id': habit.id,
      'user_id': user.id,
      'completed_date': todayString,
    });

    final newCurrent = await calculateStreak(habit);
    final newLongest = newCurrent > habit.longestStreak
        ? newCurrent
        : habit.longestStreak;

    // Update streaks
    await _supabase
        .from('habits')
        .update({
          'current_streak': newCurrent,
          'longest_streak': newLongest,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', habit.id);
  }

  // ==========================================================
  // Check if Habit Completed Today
  // ==========================================================

  Future<bool> isCompletedToday(String habitId) async {
    final user = _supabase.auth.currentUser;

    if (user == null) return false;

    final today = DateTime.now();

    final todayString =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    final response = await _supabase
        .from('habit_logs')
        .select()
        .eq('habit_id', habitId)
        .eq('user_id', user.id)
        .eq('completed_date', todayString);

    return (response as List).isNotEmpty;
  }

  // ==========================================================
  // Get Completion Count
  // ==========================================================

  Future<int> getCompletionCount(String habitId) async {
    final response = await _supabase
        .from('habit_logs')
        .select()
        .eq('habit_id', habitId);

    return (response as List).length;
  }

  // ==========================================================
  // Get Completion History
  // ==========================================================

  Future<List<DateTime>> getCompletionHistory(String habitId) async {
    final response = await _supabase
        .from('habit_logs')
        .select('completed_date')
        .eq('habit_id', habitId)
        .order('completed_date');

    return (response as List)
        .map((e) => DateTime.parse(e['completed_date']))
        .toList();
  }

  Future<int> calculateStreak(HabitModel habit) async {
    final user = _supabase.auth.currentUser;

    if (user == null) return 1;

    final yesterday = DateTime.now().subtract(const Duration(days: 1));

    final yesterdayString =
        "${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}";

    final response = await _supabase
        .from('habit_logs')
        .select()
        .eq('habit_id', habit.id)
        .eq('user_id', user.id)
        .eq('completed_date', yesterdayString);

    if ((response as List).isEmpty) {
      return 1;
    }

    return habit.currentStreak + 1;
  }
}
