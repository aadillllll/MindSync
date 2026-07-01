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

    return (response as List).map((task) => TaskModel.fromMap(task)).toList();
  }

  // =========================================================
  // Create Task
  // =========================================================

  Future<void> createTask(TaskModel task) async {
    final data = task.toMap();

    // Let PostgreSQL generate the UUID
    data.remove('id');

    // Let PostgreSQL handle timestamps if defaults/triggers exist
    data.remove('created_at');
    data.remove('updated_at');

    await _supabase.from('tasks').insert(data);
  }

  // =========================================================
  // Update Task
  // =========================================================

  Future<void> updateTask(TaskModel task) async {
    await _supabase.from('tasks').update(task.toMap()).eq('id', task.id);
  }

  // =========================================================
  // Delete Task
  // =========================================================

  Future<void> deleteTask(String taskId) async {
    await _supabase.from('tasks').delete().eq('id', taskId);
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
