import '../../analytics/models/analytics_model.dart';
import '../../calendar/models/calendar_event.dart';
import '../../habits/models/habit_model.dart';
import '../../profile/models/profile_model.dart';
import '../../tasks/models/task_model.dart';

class DashboardModel {
  final ProfileModel profile;

  final String greeting;

  final String aiBrief;

  /// AI's recommendation for what the user should focus on today.
  final String recommendedFocus;

  final List<TaskModel> todayTasks;

  final List<TaskModel> upcomingDeadlines;

  final List<CalendarEvent> todayEvents;

  final List<HabitModel> todayHabits;

  /// All productivity statistics come from AnalyticsService.
  final AnalyticsModel analytics;

  final DateTime lastUpdated;

  const DashboardModel({
    required this.profile,
    required this.greeting,
    required this.aiBrief,
    required this.recommendedFocus,
    required this.todayTasks,
    required this.upcomingDeadlines,
    required this.todayEvents,
    required this.todayHabits,
    required this.analytics,
    required this.lastUpdated,
  });
}
