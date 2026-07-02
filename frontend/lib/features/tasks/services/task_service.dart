import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/task_model.dart';

class TaskService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // =========================================================
  // Get Current User Tasks
  // =========================================================

  Future<List<TaskModel>> getTasks() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return [];

    final response = await _supabase
        .from('tasks')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return (response as List).map((e) => TaskModel.fromMap(e)).toList();
  }

  // =========================================================
  // Create Task
  // =========================================================

  Future<void> createTask(TaskModel task) async {
    final data = task.toMap();

    data.remove('id');
    data.remove('created_at');
    data.remove('updated_at');

    await _supabase.from('tasks').insert(data);
  }

  // =========================================================
  // Update Task
  // =========================================================

  Future<void> updateTask(TaskModel task) async {
    await _supabase
        .from('tasks')
        .update({
          'title': task.title,
          'description': task.description,
          'priority': task.priority,
          'status': task.status,
          'due_date': task.dueDate?.toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', task.id);
  }

  // =========================================================
  // Delete Task
  // =========================================================

  Future<void> deleteTask(String taskId) async {
    await _supabase.from('tasks').delete().eq('id', taskId);
  }

  // =========================================================
  // Mark Completed
  // =========================================================

  Future<void> markTaskCompleted(String taskId) async {
    await _supabase
        .from('tasks')
        .update({
          'status': 'Completed',
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', taskId);
  }

  // =========================================================
  // Get Single Task
  // =========================================================

  Future<TaskModel?> getTask(String id) async {
    final response = await _supabase
        .from('tasks')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;

    return TaskModel.fromMap(response);
  }
}
