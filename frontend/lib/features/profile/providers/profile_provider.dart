import 'package:flutter/material.dart';

import '../models/profile_model.dart';
import '../services/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();

  ProfileModel? _profile;

  bool _isLoading = false;

  ProfileModel? get profile => _profile;

  bool get isLoading => _isLoading;

  Future<void> loadProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      _profile = await _profileService.getCurrentProfile();
    } catch (e) {
      debugPrint('ProfileProvider Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> updateProfile(ProfileModel profile) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _profileService.updateProfile(profile);

      // Reload latest profile from Supabase
      _profile = await _profileService.getCurrentProfile();

      return true;
    } catch (e) {
      debugPrint("Update Profile Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateAvatar(String avatarUrl) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _profileService.updateAvatarUrl(avatarUrl);

      _profile = await _profileService.getCurrentProfile();

      return true;
    } catch (e) {
      debugPrint("Avatar Update Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshProfile() async {
    _profile = await _profileService.getCurrentProfile();
    notifyListeners();
  }

  void clearProfile() {
    _profile = null;
    notifyListeners();
  }
}
