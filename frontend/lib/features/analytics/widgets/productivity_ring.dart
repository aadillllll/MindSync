import 'package:flutter/material.dart';

import 'insight_card.dart';
import 'productivity_info.dart';
import 'progress_ring.dart';
import 'weekly_stats_row.dart';

class ProductivityRing extends StatelessWidget {
  final double progress;
  final int percentage;

  final int goals;
  final double focusHours;

  final String message;
  final String insight;

  const ProductivityRing({
    super.key,
    required this.progress,
    required this.percentage,
    required this.goals,
    required this.focusHours,
    required this.message,
    required this.insight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B2336), Color(0xFF151C2D)],
        ),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          ProgressRing(percentage: percentage, progress: progress),

          const SizedBox(height: 24),

          ProductivityInfo(percentage: percentage, message: message),

          const SizedBox(height: 24),

          const Divider(color: Colors.white12, thickness: 1),

          const SizedBox(height: 20),

          WeeklyStatsRow(goals: goals, focusHours: focusHours),

          const SizedBox(height: 20),

          InsightCard(insight: insight),
        ],
      ),
    );
  }
}
