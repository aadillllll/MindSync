import 'package:flutter/material.dart';

import '../models/dashboard_model.dart';
import '../services/dashboard_service.dart';

class DashboardProvider extends ChangeNotifier {
  final DashboardService _dashboardService = DashboardService();

  DashboardModel? _dashboard;

  DashboardModel? get dashboard => _dashboard;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _error;

  String? get error => _error;

  Future<void> loadDashboard() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _dashboard = await _dashboardService.getDashboard();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadDashboard();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
