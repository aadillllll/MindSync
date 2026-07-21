import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../analytics/providers/analytics_provider.dart';
import 'productivity_ring.dart';
import 'productivity_stat_card.dart';

class ProductivitySection extends StatelessWidget {
  const ProductivitySection({super.key});

  String _periodText(AnalyticsPeriod period) {
    switch (period) {
      case AnalyticsPeriod.today:
        return "Today";
      case AnalyticsPeriod.week:
        return "This Week";
      case AnalyticsPeriod.month:
        return "This Month";
      case AnalyticsPeriod.year:
        return "This Year";
    }
  }

  @override
  Widget build(BuildContext context) {
    final analyticsProvider = context.watch<AnalyticsProvider>();

    final analytics = analyticsProvider.analytics;

    final productivityScore = analytics?.productivityScore.round() ?? 0;
    final completedTasks = analytics?.completedTasks ?? 0;
    final habitStreak = analytics?.habitStreak ?? 0;
    final completedGoals =
        analytics?.goals.where((g) => g.progress >= 1.0).length ?? 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B2336), Color(0xFF151C2D)],
        ),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //--------------------------------------------------
          // Header
          //--------------------------------------------------
          Row(
            children: [
              const Icon(
                Icons.trending_up_rounded,
                color: Colors.white70,
                size: 22,
              ),
              const SizedBox(width: 10),

              const Expanded(
                child: Text(
                  "Productivity Overview",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              PopupMenuButton<AnalyticsPeriod>(
                onSelected: (period) {
                  context.read<AnalyticsProvider>().changePeriod(period);
                },
                color: const Color(0xFF202B44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: AnalyticsPeriod.today,
                    child: Text("Today"),
                  ),
                  PopupMenuItem(
                    value: AnalyticsPeriod.week,
                    child: Text("This Week"),
                  ),
                  PopupMenuItem(
                    value: AnalyticsPeriod.month,
                    child: Text("This Month"),
                  ),
                  PopupMenuItem(
                    value: AnalyticsPeriod.year,
                    child: Text("This Year"),
                  ),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _periodText(analyticsProvider.selectedPeriod),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white70,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          //--------------------------------------------------
          // First Row
          //--------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductivityRing(
                progress: productivityScore / 100,
                percentage: productivityScore,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: SizedBox(
                  height: 150,
                  child: ProductivityStatCard(
                    icon: Icons.task_alt_rounded,
                    iconColor: Colors.deepPurpleAccent,
                    value: completedTasks.toString(),
                    title: "Tasks",
                    progress: "Completed",
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          //--------------------------------------------------
          // Second Row
          //--------------------------------------------------
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 150,
                  child: ProductivityStatCard(
                    icon: Icons.track_changes,
                    iconColor: Colors.blueAccent,
                    value: habitStreak.toString(),
                    title: "Habit Streak",
                    progress: "Best Streak",
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: SizedBox(
                  height: 150,
                  child: ProductivityStatCard(
                    icon: Icons.flag_rounded,
                    iconColor: Colors.amberAccent,
                    value: completedGoals.toString(),
                    title: "Goals",
                    progress: "Completed",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
