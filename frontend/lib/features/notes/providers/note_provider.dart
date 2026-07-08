import 'package:flutter/material.dart';

import '../models/note_model.dart';
import '../services/note_service.dart';

class NoteProvider extends ChangeNotifier {
  final NoteService _service = NoteService();

  List<NoteModel> _notes = [];

  List<NoteModel> _filteredNotes = [];

  String _searchQuery = '';

  bool _isLoading = false;

  List<NoteModel> get notes => _notes;

  List<NoteModel> get displayedNotes =>
      _searchQuery.isEmpty ? _notes : _filteredNotes;

  String get searchQuery => _searchQuery;

  bool get isLoading => _isLoading;

  // ==========================================================
  // Load Notes
  // ==========================================================

  Future<void> loadNotes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _notes = await _service.getNotes();

      if (_searchQuery.isNotEmpty) {
        searchNotes(_searchQuery);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================================
  // Create Note
  // ==========================================================

  Future<bool> createNote(NoteModel note) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _service.createNote(note);

      await loadNotes();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================================
  // Update Note
  // ==========================================================

  Future<bool> updateNote(NoteModel note) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _service.updateNote(note);

      await loadNotes();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================================
  // Delete Note
  // ==========================================================

  Future<bool> deleteNote(String id) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _service.deleteNote(id);

      await loadNotes();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================================
  // Toggle Pin
  // ==========================================================

  Future<void> togglePin(NoteModel note) async {
    await _service.togglePin(note);
    await loadNotes();
  }

  // ==========================================================
  // Toggle Favorite
  // ==========================================================

  Future<void> toggleFavorite(NoteModel note) async {
    await _service.toggleFavorite(note);
    await loadNotes();
  }

  // ==========================================================
  // Local Search
  // ==========================================================

  void searchNotes(String query) {
    _searchQuery = query;

    if (query.trim().isEmpty) {
      _filteredNotes = [];
    } else {
      final q = query.toLowerCase();

      _filteredNotes = _notes.where((note) {
        return note.title.toLowerCase().contains(q) ||
            note.content.toLowerCase().contains(q) ||
            note.category.toLowerCase().contains(q);
      }).toList();
    }

    notifyListeners();
  }

  // ==========================================================
  // Statistics
  // ==========================================================

  int get totalNotes => _notes.length;

  int get pinnedNotes => _notes.where((e) => e.isPinned).length;

  int get favoriteNotes => _notes.where((e) => e.isFavorite).length;

  List<NoteModel> get pinned => _notes.where((e) => e.isPinned).toList();

  List<NoteModel> get favorites => _notes.where((e) => e.isFavorite).toList();

  List<NoteModel> get normal => _notes.where((e) => !e.isPinned).toList();
}
