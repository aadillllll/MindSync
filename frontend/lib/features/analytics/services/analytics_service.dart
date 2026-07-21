import '../../goals/models/goal_model.dart';
import '../../goals/services/goal_service.dart';
import '../../habits/models/habit_model.dart';
import '../../habits/services/habit_service.dart';
import '../../tasks/models/task_model.dart';
import '../../tasks/services/task_service.dart';
import '../providers/analytics_provider.dart';
import '../models/achievement_model.dart';
import '../models/analytics_model.dart';
import '../models/goal_progress_model.dart';
import '../models/weekly_activity_model.dart';

class AnalyticsService {
  final TaskService _taskService = TaskService();
  final HabitService _habitService = HabitService();
  final GoalService _goalService = GoalService();

  bool _isInRange(DateTime? date, DateTime start, DateTime end) {
    if (date == null) return false;

    return !date.isBefore(start) && !date.isAfter(end);
  }

  DateTime _startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  DateTime _endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  Future<AnalyticsModel> getAnalytics({required AnalyticsPeriod period}) async {
    final now = DateTime.now();

    late DateTime startDate;
    late DateTime endDate;

    switch (period) {
      case AnalyticsPeriod.today:
        startDate = _startOfDay(now);
        endDate = _endOfDay(now);
        break;

      case AnalyticsPeriod.week:
        startDate = _startOfDay(now.subtract(Duration(days: now.weekday - 1)));

        endDate = _endOfDay(startDate.add(const Duration(days: 6)));
        break;

      case AnalyticsPeriod.month:
        startDate = DateTime(now.year, now.month, 1);

        endDate = _endOfDay(DateTime(now.year, now.month + 1, 0));
        break;

      case AnalyticsPeriod.year:
        startDate = DateTime(now.year, 1, 1);

        endDate = _endOfDay(DateTime(now.year, 12, 31));
        break;
    }

    final results = await Future.wait([
      _taskService.getTasks(),
      _habitService.getHabits(),
      _habitService.getHabitLogs(),
      _goalService.getGoals(),
    ]);

    final tasks = results[0] as List<TaskModel>;
    final habits = results[1] as List<HabitModel>;
    final habitLogs = results[2] as List<Map<String, dynamic>>;
    final goals = results[3] as List<GoalModel>;
    final completedGoals = goals.where((goal) => goal.completed).length;

    // ===========================
    // TASKS
    // ===========================

    final filteredCompletedTasks = tasks.where((task) {
      return task.isCompleted &&
          _isInRange(task.completedAt, startDate, endDate);
    }).toList();

    final completedTasks = filteredCompletedTasks.length;

    final pendingTasks = tasks.where((task) => !task.isCompleted).length;

    final totalTasks = completedTasks + pendingTasks;

    final taskCompletionRate = totalTasks == 0
        ? 0.0
        : completedTasks / totalTasks;

    // ===========================
    // HABITS
    // ===========================

    final activeHabits = habits.where((habit) => habit.isActive).toList();

    final filteredHabitLogs = habitLogs.where((log) {
      final completedDate = DateTime.parse(log['completed_date']);

      return _isInRange(completedDate, startDate, endDate);
    }).toList();

    final completedHabits = filteredHabitLogs.length;

    final habitCompletionRate = activeHabits.isEmpty
        ? 0.0
        : completedHabits / activeHabits.length;

    final habitStreak = habits.isEmpty
        ? 0
        : habits
              .map((habit) => habit.currentStreak)
              .reduce((a, b) => a > b ? a : b);

    // ===========================
    // GOALS
    // ===========================

    double averageGoalProgress = 0;

    if (goals.isNotEmpty) {
      averageGoalProgress =
          goals.map((goal) => goal.progressValue).reduce((a, b) => a + b) /
          goals.length;
    }

    // ===========================
    // PRODUCTIVITY SCORE
    // ===========================

    final productivityScore =
        ((taskCompletionRate * 0.7) + (habitCompletionRate * 0.3)) * 100;

    // ===========================
    // GOAL PROGRESS
    // ===========================

    final goalProgress = goals
        .map(
          (goal) => GoalProgressModel(
            title: goal.title,
            progress: goal.progressValue,
            icon: "flag",
          ),
        )
        .toList();

    // ===========================
    // WEEKLY ACTIVITY
    // ===========================

    final weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    final weeklyActivity = <WeeklyActivityModel>[];

    DateTime chartStart;

    switch (period) {
      case AnalyticsPeriod.today:
        chartStart = _startOfDay(now);
        break;

      case AnalyticsPeriod.week:
        chartStart = _startOfDay(now.subtract(Duration(days: now.weekday - 1)));
        break;

      case AnalyticsPeriod.month:
        chartStart = DateTime(now.year, now.month, 1);
        break;

      case AnalyticsPeriod.year:
        chartStart = DateTime(now.year, 1, 1);
        break;
    }

    for (int i = 0; i < 7; i++) {
      final day = chartStart.add(Duration(days: i));

      final dayStart = _startOfDay(day);

      final dayEnd = _endOfDay(day);

      final taskCount = tasks.where((task) {
        return task.isCompleted &&
            _isInRange(task.completedAt, dayStart, dayEnd);
      }).length;

      final habitCount = habitLogs.where((log) {
        final completedDate = DateTime.parse(log['completed_date']);

        return _isInRange(completedDate, dayStart, dayEnd);
      }).length;

      String label;

      if (period == AnalyticsPeriod.today) {
        label = "Today";
      } else {
        label = weekDays[day.weekday - 1];
      }

      weeklyActivity.add(
        WeeklyActivityModel(
          day: label,
          completedTasks: taskCount,
          completedHabits: habitCount,
        ),
      );
    }

    // For month/year, keep only the latest 7 points
    if (weeklyActivity.length > 7) {
      weeklyActivity.removeRange(0, weeklyActivity.length - 7);
    }

    // ===========================
    // ACHIEVEMENTS
    // ===========================

    // ===========================
    // ACHIEVEMENTS
    // ===========================

    final achievements = <AchievementModel>[
      AchievementModel(
        title: "Task Beginner",
        description: "Complete 10 tasks",
        icon: "task",
        unlocked: completedTasks >= 10,
      ),

      AchievementModel(
        title: "Task Pro",
        description: "Complete 50 tasks",
        icon: "task",
        unlocked: completedTasks >= 50,
      ),

      AchievementModel(
        title: "Task Legend",
        description: "Complete 100 tasks",
        icon: "workspace_premium",
        unlocked: completedTasks >= 100,
      ),

      AchievementModel(
        title: "Habit Starter",
        description: "Reach a 3 day streak",
        icon: "local_fire_department",
        unlocked: habitStreak >= 3,
      ),

      AchievementModel(
        title: "Habit Master",
        description: "Reach a 7 day streak",
        icon: "local_fire_department",
        unlocked: habitStreak >= 7,
      ),

      AchievementModel(
        title: "Habit Champion",
        description: "Reach a 30 day streak",
        icon: "workspace_premium",
        unlocked: habitStreak >= 30,
      ),

      AchievementModel(
        title: "Goal Crusher",
        description: "Complete your first goal",
        icon: "emoji_events",
        unlocked: goals.any((goal) => goal.completed),
      ),

      AchievementModel(
        title: "Goal Expert",
        description: "Complete 5 goals",
        icon: "workspace_premium",
        unlocked: goals.where((goal) => goal.completed).length >= 5,
      ),

      AchievementModel(
        title: "Productivity Star",
        description: "Reach 80% productivity",
        icon: "emoji_events",
        unlocked: productivityScore >= 80,
      ),

      AchievementModel(
        title: "Productivity Master",
        description: "Reach 90% productivity",
        icon: "workspace_premium",
        unlocked: productivityScore >= 90,
      ),
    ];

    achievements.sort((a, b) {
      if (a.unlocked == b.unlocked) return 0;
      return a.unlocked ? -1 : 1;
    });

    // ===========================
    // AI INSIGHT
    // ===========================

    String insight;

    if (productivityScore >= 80) {
      insight =
          "Excellent work! You're maintaining strong productivity. Keep your momentum going.";
    } else if (productivityScore >= 60) {
      insight =
          "You're making good progress. Completing a few more habits will improve your productivity.";
    } else if (completedTasks == 0 && completedHabits == 0) {
      switch (period) {
        case AnalyticsPeriod.today:
          insight =
              "You haven't completed anything today yet. Start with one small task to build momentum.";
          break;

        case AnalyticsPeriod.week:
          insight =
              "No activity has been recorded this week. Completing a few tasks and habits will improve your weekly productivity.";
          break;

        case AnalyticsPeriod.month:
          insight =
              "Your monthly productivity is currently low. Consistent daily progress will make a big difference.";
          break;

        case AnalyticsPeriod.year:
          insight =
              "No completed activity has been recorded this year. Set a few achievable goals and build consistency.";
          break;
      }
    } else {
      insight =
          "Your productivity is below your potential. Focus on completing your highest priority task first.";
    }

    // ===========================
    // RETURN MODEL
    // ===========================

    return AnalyticsModel(
      productivityScore: productivityScore.clamp(0.0, 100.0),

      completedTasks: completedTasks,

      pendingTasks: pendingTasks,

      habitStreak: habitStreak,

      focusHours: 0,

      studyHours: 0,

      weeklyActivity: weeklyActivity,

      goals: goalProgress,

      achievements: achievements,

      aiInsight: insight,

      completedGoals: completedGoals,
    );
  }
}
