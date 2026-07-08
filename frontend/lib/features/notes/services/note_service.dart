import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/note_model.dart';

class NoteService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // ==========================================================
  // Get All Notes
  // ==========================================================

  Future<List<NoteModel>> getNotes() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return [];

    final response = await _supabase
        .from('notes')
        .select()
        .eq('user_id', user.id)
        .order('is_pinned', ascending: false)
        .order('updated_at', ascending: false);

    return (response as List).map((e) => NoteModel.fromMap(e)).toList();
  }

  // ==========================================================
  // Get Single Note
  // ==========================================================

  Future<NoteModel?> getNote(String id) async {
    final response = await _supabase
        .from('notes')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;

    return NoteModel.fromMap(response);
  }

  // ==========================================================
  // Create Note
  // ==========================================================

  Future<void> createNote(NoteModel note) async {
    await _supabase.from('notes').insert(note.toInsertMap());
  }

  // ==========================================================
  // Update Note
  // ==========================================================

  Future<void> updateNote(NoteModel note) async {
    await _supabase
        .from('notes')
        .update({
          'title': note.title,
          'content': note.content,
          'category': note.category,
          'is_pinned': note.isPinned,
          'is_favorite': note.isFavorite,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', note.id);
  }

  // ==========================================================
  // Delete Note
  // ==========================================================

  Future<void> deleteNote(String id) async {
    await _supabase.from('notes').delete().eq('id', id);
  }

  // ==========================================================
  // Toggle Pin
  // ==========================================================

  Future<void> togglePin(NoteModel note) async {
    await _supabase
        .from('notes')
        .update({
          'is_pinned': !note.isPinned,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', note.id);
  }

  // ==========================================================
  // Toggle Favorite
  // ==========================================================

  Future<void> toggleFavorite(NoteModel note) async {
    await _supabase
        .from('notes')
        .update({
          'is_favorite': !note.isFavorite,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', note.id);
  }

  // ==========================================================
  // Search Notes
  // ==========================================================

  Future<List<NoteModel>> searchNotes(String query) async {
    final user = _supabase.auth.currentUser;

    if (user == null) return [];

    final response = await _supabase
        .from('notes')
        .select()
        .eq('user_id', user.id)
        .or('title.ilike.%$query%,content.ilike.%$query%');

    return (response as List).map((e) => NoteModel.fromMap(e)).toList();
  }
}
