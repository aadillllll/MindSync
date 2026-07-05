import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/goal_model.dart';

class GoalService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // ==========================================
  // Get All Goals
  // ==========================================

  Future<List<GoalModel>> getGoals() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return [];

    final response = await _supabase
        .from('goals')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return (response as List).map((e) => GoalModel.fromMap(e)).toList();
  }

  // ==========================================
  // Get Single Goal
  // ==========================================

  Future<GoalModel?> getGoal(String id) async {
    final response = await _supabase
        .from('goals')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;

    return GoalModel.fromMap(response);
  }

  // ==========================================
  // Create Goal
  // ==========================================

  Future<void> createGoal(GoalModel goal) async {
    final data = goal.toMap();

    data.remove('id');
    data.remove('created_at');
    data.remove('updated_at');

    await _supabase.from('goals').insert(data);
  }

  // ==========================================
  // Update Goal
  // ==========================================

  Future<void> updateGoal(GoalModel goal) async {
    await _supabase
        .from('goals')
        .update({
          'title': goal.title,
          'description': goal.description,
          'target': goal.target,
          'progress': goal.progress,
          'deadline': goal.deadline?.toIso8601String(),
          'completed': goal.completed,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', goal.id);
  }

  // ==========================================
  // Update Progress
  // ==========================================

  Future<void> updateProgress(String goalId, int progress) async {
    final goal = await getGoal(goalId);

    if (goal == null) return;

    final completed = progress >= goal.target;

    await _supabase
        .from('goals')
        .update({
          'progress': progress,
          'completed': completed,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', goalId);
  }

  // ==========================================
  // Delete Goal
  // ==========================================

  Future<void> deleteGoal(String goalId) async {
    await _supabase.from('goals').delete().eq('id', goalId);
  }

  Future<void> completeGoal(String goalId) async {
    await _supabase
        .from('goals')
        .update({
          'completed': true,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', goalId);
  }
}
