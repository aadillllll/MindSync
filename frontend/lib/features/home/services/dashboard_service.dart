import '../../analytics/models/analytics_model.dart';
import '../../analytics/providers/analytics_provider.dart';
import '../../analytics/services/analytics_service.dart';

import '../../habits/models/habit_model.dart';
import '../../habits/services/habit_service.dart';

import '../../profile/models/profile_model.dart';
import '../../profile/services/profile_service.dart';

import '../../tasks/models/task_model.dart';
import '../../tasks/services/task_service.dart';

import '../../calendar/models/calendar_event.dart';
import '../../calendar/services/calendar_service.dart';

import '../models/dashboard_model.dart';

class DashboardService {
  final ProfileService _profileService = ProfileService();

  final TaskService _taskService = TaskService();

  final HabitService _habitService = HabitService();

  final AnalyticsService _analyticsService = AnalyticsService();

  final CalendarService _calendarService = CalendarService();

  Future<DashboardModel> getDashboard() async {
    final results = await Future.wait([
      _profileService.getCurrentProfile(),
      _taskService.getTasks(),
      _habitService.getHabits(),
      _analyticsService.getAnalytics(period: AnalyticsPeriod.today),
      _calendarService.getEvents(),
    ]);

    final profile = results[0] as ProfileModel;

    final tasks = results[1] as List<TaskModel>;

    final habits = results[2] as List<HabitModel>;

    final analytics = results[3] as AnalyticsModel;

    final events = results[4] as List<CalendarEvent>;

    final now = DateTime.now();

    // ===========================
    // Greeting
    // ===========================

    String greeting;

    if (now.hour < 12) {
      greeting = "Good Morning";
    } else if (now.hour < 17) {
      greeting = "Good Afternoon";
    } else {
      greeting = "Good Evening";
    }

    // ===========================
    // Today's Tasks
    // ===========================

    final todayTasks = tasks.where((task) {
      // Don't show completed tasks
      if (task.isCompleted) return false;

      if (task.dueDate == null) return false;

      return task.dueDate!.year == now.year &&
          task.dueDate!.month == now.month &&
          task.dueDate!.day == now.day;
    }).toList();

    // ===========================
    // Upcoming Deadlines
    // ===========================

    final upcomingDeadlines = tasks.where((task) {
      // Don't show completed tasks
      if (task.isCompleted) return false;

      if (task.dueDate == null) return false;

      return task.dueDate!.isAfter(now);
    }).toList();

    upcomingDeadlines.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

    // ===========================
    // Today's Schedule
    // ===========================

    final todayEvents = events.where((event) {
      return event.startDateTime.year == now.year &&
          event.startDateTime.month == now.month &&
          event.startDateTime.day == now.day;
    }).toList();

    todayEvents.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));

    // ===========================
    // Today's Habits
    // ===========================

    final todayHabits = habits.where((habit) => habit.isActive).toList();

    // ===========================
    // AI Brief
    // ===========================

    String aiBrief;

    if (todayTasks.isEmpty) {
      aiBrief =
          "You don't have any scheduled tasks today. Great opportunity to plan ahead.";
    } else if (todayTasks.length >= 5) {
      aiBrief =
          "You have a busy day ahead. Focus on completing your highest priority task first.";
    } else {
      aiBrief =
          "You're making good progress. Stay consistent and complete today's remaining tasks.";
    }

    // ===========================
    // Recommended Focus
    // ===========================

    String recommendedFocus = "You're all caught up!";

    final highPriorityTasks = todayTasks
        .where(
          (task) =>
              !task.isCompleted && (task.priority?.toLowerCase() == "high"),
        )
        .toList();

    if (highPriorityTasks.isNotEmpty) {
      recommendedFocus = "Complete '${highPriorityTasks.first.title}' first.";
    } else {
      final mediumPriorityTasks = todayTasks
          .where(
            (task) =>
                !task.isCompleted && (task.priority?.toLowerCase() == "medium"),
          )
          .toList();

      if (mediumPriorityTasks.isNotEmpty) {
        recommendedFocus =
            "Complete '${mediumPriorityTasks.first.title}' next.";
      } else {
        final pendingTasks = todayTasks
            .where((task) => !task.isCompleted)
            .toList();

        if (pendingTasks.isNotEmpty) {
          recommendedFocus = "Focus on '${pendingTasks.first.title}'.";
        } else {
          final pendingHabits = todayHabits
              .where((habit) => !habit.completedToday)
              .toList();

          if (pendingHabits.isNotEmpty) {
            recommendedFocus =
                "Don't forget your '${pendingHabits.first.title}' habit.";
          }
        }
      }
    }

    // ===========================
    // Return Dashboard
    // ===========================

    return DashboardModel(
      profile: profile,
      greeting: greeting,
      aiBrief: aiBrief,
      recommendedFocus: recommendedFocus,
      todayTasks: todayTasks,
      upcomingDeadlines: upcomingDeadlines.take(5).toList(),
      todayEvents: todayEvents,
      todayHabits: todayHabits,
      analytics: analytics,
      lastUpdated: DateTime.now(),
    );
  }
}
