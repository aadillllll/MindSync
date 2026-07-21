import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/analytics_provider.dart';

import '../widgets/achievement_tile.dart';
import '../widgets/ai_insight_card.dart';
import '../widgets/analytics_header.dart';
import '../widgets/goal_tile.dart';
import '../widgets/performance_tile.dart';
import '../widgets/productivity_ring.dart';
import '../widgets/weekly_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AnalyticsProvider>().loadAnalytics();
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData _goalIcon(String icon) {
      switch (icon.toLowerCase()) {
        case "school":
          return Icons.school_rounded;

        case "fitness":
          return Icons.fitness_center_rounded;

        case "book":
          return Icons.menu_book_rounded;

        case "flag":
          return Icons.flag_rounded;

        default:
          return Icons.flag_rounded;
      }
    }

    Color _goalColor(double progress) {
      if (progress >= 0.80) {
        return Colors.green;
      }

      if (progress >= 0.50) {
        return Colors.orange;
      }

      return Colors.redAccent;
    }

    IconData _achievementIcon(String icon) {
      switch (icon.toLowerCase()) {
        case "task":
          return Icons.task_alt_rounded;

        case "emoji_events":
          return Icons.emoji_events_rounded;

        case "local_fire_department":
          return Icons.local_fire_department_rounded;

        case "workspace_premium":
          return Icons.workspace_premium_rounded;

        default:
          return Icons.emoji_events_rounded;
      }
    }

    final provider = context.watch<AnalyticsProvider>();

    if (provider.isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0B1120),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.error != null) {
      return Scaffold(
        backgroundColor: const Color(0xFF0B1120),
        body: Center(
          child: Text(
            provider.error!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final analytics = provider.analytics!;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.deepPurpleAccent,
          backgroundColor: const Color(0xFF1E293B),
          onRefresh: () async {
            await context.read<AnalyticsProvider>().refresh();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AnalyticsHeader(),

                const SizedBox(height: 28),

                ProductivityRing(
                  progress: analytics.productivityScore / 100,
                  percentage: analytics.productivityScore.round(),
                  goals: analytics.goals.length,
                  focusHours: analytics.focusHours.toDouble(),
                  message: analytics.productivityScore >= 80
                      ? "Excellent! You're performing really well this week."
                      : analytics.productivityScore >= 60
                      ? "Good progress. Keep your momentum going!"
                      : "Let's improve your productivity today.",
                  insight: analytics.aiInsight,
                ),

                const SizedBox(height: 30),

                WeeklyChart(activity: analytics.weeklyActivity),

                const SizedBox(height: 30),

                const Text(
                  "Performance",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                PerformanceTile(
                  icon: Icons.task_alt_rounded,
                  color: Colors.deepPurpleAccent,
                  title: "Tasks Completed",
                  value: analytics.completedTasks.toString(),
                  subtitle: "from last week",
                ),

                PerformanceTile(
                  icon: Icons.timer_outlined,
                  color: Colors.green,
                  title: "Focus Hours",
                  value: analytics.focusHours.toString(),
                  subtitle: "coming soon",
                ),

                PerformanceTile(
                  icon: Icons.menu_book_rounded,
                  color: Colors.orange,
                  title: "Study Hours",
                  value: analytics.studyHours.toString(),
                  subtitle: "coming soon",
                ),

                PerformanceTile(
                  icon: Icons.local_fire_department_rounded,
                  color: Colors.redAccent,
                  title: "Habit Streak",
                  value: analytics.habitStreak.toString(),
                  subtitle: "Consecutive days",
                ),

                const SizedBox(height: 30),

                const Text(
                  "Goals",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                if (analytics.goals.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF182135),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.flag_outlined,
                          size: 52,
                          color: Colors.white38,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "No Goals Yet",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Create your first goal to start tracking your progress.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white60, height: 1.5),
                        ),
                      ],
                    ),
                  )
                else
                  ...analytics.goals.map(
                    (goal) => GoalTile(
                      icon: _goalIcon(goal.icon),
                      color: _goalColor(goal.progress),
                      title: goal.title,
                      progress: goal.progress,
                      percentage: "${(goal.progress * 100).round()}%",
                    ),
                  ),

                const SizedBox(height: 30),

                AIInsightCard(insight: analytics.aiInsight),

                const SizedBox(height: 30),

                const Text(
                  "Achievements",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                ...analytics.achievements.map(
                  (achievement) => AchievementTile(
                    icon: _achievementIcon(achievement.icon),
                    color: Colors.amber,
                    title: achievement.title,
                    subtitle: achievement.description,
                    unlocked: achievement.unlocked,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
