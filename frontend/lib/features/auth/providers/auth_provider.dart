import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../profile/services/profile_service.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final ProfileService _profileService = ProfileService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  User? get currentUser => _authService.currentUser;

  Stream<AuthState> get authState => _authService.authState;

  Future<AuthResponse?> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        await _profileService.createProfile(
          id: response.user!.id,
          fullName: fullName,
        );
      }

      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<AuthResponse?> signIn({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      return await _authService.signIn(email: email, password: password);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners();
  }
}
