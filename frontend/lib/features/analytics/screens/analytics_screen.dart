import 'package:flutter/material.dart';

import '../widgets/achievement_tile.dart';
import '../widgets/ai_insight_card.dart';
import '../widgets/analytics_header.dart';
import '../widgets/goal_tile.dart';
import '../widgets/performance_tile.dart';
import '../widgets/productivity_ring.dart';
import '../widgets/weekly_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AnalyticsHeader(),

              const SizedBox(height: 28),

              const ProductivityRing(progress: .87, percentage: 87),

              const SizedBox(height: 30),

              const WeeklyChart(),

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

              const PerformanceTile(
                icon: Icons.task_alt_rounded,
                color: Colors.deepPurpleAccent,
                title: "Tasks Completed",
                value: "92",
                subtitle: "+18% from last week",
              ),

              const PerformanceTile(
                icon: Icons.timer_outlined,
                color: Colors.green,
                title: "Focus Hours",
                value: "14.5",
                subtitle: "Hours this week",
              ),

              const PerformanceTile(
                icon: Icons.menu_book_rounded,
                color: Colors.orange,
                title: "Study Hours",
                value: "26",
                subtitle: "Hours completed",
              ),

              const PerformanceTile(
                icon: Icons.local_fire_department_rounded,
                color: Colors.redAccent,
                title: "Habit Streak",
                value: "18",
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

              const GoalTile(
                icon: Icons.school_rounded,
                color: Colors.deepPurpleAccent,
                title: "Semester Goal",
                progress: .82,
                percentage: "82%",
              ),

              const GoalTile(
                icon: Icons.fitness_center_rounded,
                color: Colors.green,
                title: "Fitness Goal",
                progress: .64,
                percentage: "64%",
              ),

              const GoalTile(
                icon: Icons.menu_book_rounded,
                color: Colors.orange,
                title: "Reading Goal",
                progress: .48,
                percentage: "48%",
              ),

              const SizedBox(height: 30),

              const AIInsightCard(),

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

              const AchievementTile(
                icon: Icons.local_fire_department_rounded,
                color: Colors.orange,
                title: "18-Day Habit Streak",
                subtitle:
                    "You've maintained your habits for 18 consecutive days.",
              ),

              const AchievementTile(
                icon: Icons.workspace_premium_rounded,
                color: Colors.amber,
                title: "Productivity Master",
                subtitle: "Achieved an 87% productivity score this week.",
              ),

              const AchievementTile(
                icon: Icons.emoji_events_rounded,
                color: Colors.green,
                title: "Task Champion",
                subtitle: "Completed more than 90 tasks this week.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
