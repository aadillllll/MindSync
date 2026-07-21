import 'weekly_activity_model.dart';
import 'goal_progress_model.dart';
import 'achievement_model.dart';

class AnalyticsModel {
  final double productivityScore;

  final int completedTasks;

  final int pendingTasks;

  final int habitStreak;

  final int completedGoals;

  final double focusHours;

  final double studyHours;

  final List<WeeklyActivityModel> weeklyActivity;

  final List<GoalProgressModel> goals;

  final List<AchievementModel> achievements;

  final String aiInsight;

  const AnalyticsModel({
    required this.productivityScore,
    required this.completedTasks,
    required this.pendingTasks,
    required this.habitStreak,
    required this.focusHours,
    required this.studyHours,
    required this.weeklyActivity,
    required this.goals,
    required this.achievements,
    required this.aiInsight,
    required this.completedGoals,
  });
}
