import 'package:flutter/material.dart';

import '../models/analytics_model.dart';
import '../services/analytics_service.dart';

enum AnalyticsPeriod { today, week, month, year }

class AnalyticsProvider extends ChangeNotifier {
  final AnalyticsService _analyticsService = AnalyticsService();

  AnalyticsPeriod _selectedPeriod = AnalyticsPeriod.week;

  AnalyticsPeriod get selectedPeriod => _selectedPeriod;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AnalyticsModel? _analytics;
  AnalyticsModel? get analytics => _analytics;

  String? _error;
  String? get error => _error;

  Future<void> changePeriod(AnalyticsPeriod period) async {
    if (_selectedPeriod == period) return;

    _selectedPeriod = period;
    await loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _analytics = await _analyticsService.getAnalytics(
        period: _selectedPeriod,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadAnalytics();
  }
}
