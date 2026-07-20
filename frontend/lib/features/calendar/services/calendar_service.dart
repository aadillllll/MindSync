import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/calendar_event.dart';

class CalendarService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // =========================================================
  // Get All Events
  // =========================================================

  Future<List<CalendarEvent>> getEvents() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return [];

    final response = await _supabase
        .from('events')
        .select()
        .eq('user_id', user.id)
        .order('start_datetime', ascending: true);

    return response
        .map<CalendarEvent>((e) => CalendarEvent.fromMap(e))
        .toList();
  }

  // =========================================================
  // Get Today's Events
  // =========================================================

  Future<List<CalendarEvent>> getTodaysEvents() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return [];

    final now = DateTime.now();

    final startOfDay = DateTime(now.year, now.month, now.day);

    final endOfDay = startOfDay.add(const Duration(days: 1));

    final response = await _supabase
        .from('events')
        .select()
        .eq('user_id', user.id)
        .gte('start_datetime', startOfDay.toIso8601String())
        .lt('start_datetime', endOfDay.toIso8601String())
        .order('start_datetime');

    return response
        .map<CalendarEvent>((e) => CalendarEvent.fromMap(e))
        .toList();
  }

  // =========================================================
  // Get Events For Selected Date
  // =========================================================

  Future<List<CalendarEvent>> getEventsForDate(DateTime date) async {
    final user = _supabase.auth.currentUser;

    if (user == null) return [];

    final start = DateTime(date.year, date.month, date.day);

    final end = start.add(const Duration(days: 1));

    final response = await _supabase
        .from('events')
        .select()
        .eq('user_id', user.id)
        .gte('start_datetime', start.toIso8601String())
        .lt('start_datetime', end.toIso8601String())
        .order('start_datetime');

    return response
        .map<CalendarEvent>((e) => CalendarEvent.fromMap(e))
        .toList();
  }

  // =========================================================
  // Create Event
  // =========================================================

  Future<void> createEvent(CalendarEvent event) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('You must be signed in to create an event.');
    }

    await _supabase.from('events').insert({
      ...event.toInsertMap(),
      'user_id': user.id,
    });
  }

  // =========================================================
  // Update Event
  // =========================================================

  Future<void> updateEvent(CalendarEvent event) async {
    await _supabase.from('events').update(event.toMap()).eq('id', event.id);
  }

  // =========================================================
  // Delete Event
  // =========================================================

  Future<void> deleteEvent(String eventId) async {
    await _supabase.from('events').delete().eq('id', eventId);
  }

  // =========================================================
  // Get Single Event
  // =========================================================

  Future<CalendarEvent?> getEvent(String eventId) async {
    final response = await _supabase
        .from('events')
        .select()
        .eq('id', eventId)
        .maybeSingle();

    if (response == null) return null;

    return CalendarEvent.fromMap(response);
  }
}
