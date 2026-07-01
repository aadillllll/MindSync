import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/profile_model.dart';

class ProfileService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Create profile after successful registration
  Future<void> createProfile({
    required String id,
    required String fullName,
  }) async {
    await _supabase.from('profiles').insert({
      'id': id,
      'full_name': fullName,
      'username': null,
      'avatar_url': null,
      'bio': null,
      'college': null,
      'course': null,
      'semester': null,
      'productivity_score': 0,
    });
  }

  /// Get current user's profile
  Future<ProfileModel?> getCurrentProfile() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return null;

    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (response == null) return null;

    return ProfileModel.fromMap(response);
  }

  /// Update profile
  Future<void> updateProfile(ProfileModel profile) async {
    await _supabase
        .from('profiles')
        .update({
          'full_name': profile.fullName,
          'username': profile.username,
          'avatar_url': profile.avatarUrl,
          'bio': profile.bio,
          'college': profile.college,
          'course': profile.course,
          'semester': profile.semester,
          'productivity_score': profile.productivityScore,
        })
        .eq('id', profile.id);
  }

  /// Check username availability
  Future<bool> usernameExists(String username) async {
    final response = await _supabase
        .from('profiles')
        .select('id')
        .eq('username', username)
        .maybeSingle();

    return response != null;
  }
}
