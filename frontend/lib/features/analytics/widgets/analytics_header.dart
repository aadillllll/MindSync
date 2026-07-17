import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/analytics_provider.dart';

class AnalyticsHeader extends StatelessWidget {
  const AnalyticsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AnalyticsProvider>();

    String periodText;

    switch (provider.selectedPeriod) {
      case AnalyticsPeriod.today:
        periodText = "Today";
        break;
      case AnalyticsPeriod.week:
        periodText = "This Week";
        break;
      case AnalyticsPeriod.month:
        periodText = "This Month";
        break;
      case AnalyticsPeriod.year:
        periodText = "This Year";
        break;
    }

    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Analytics",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Track your productivity journey",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ],
          ),
        ),

        PopupMenuButton<AnalyticsPeriod>(
          color: const Color(0xFF1E293B),
          onSelected: (period) {
            provider.changePeriod(period);
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: AnalyticsPeriod.today, child: Text("Today")),
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .06),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(periodText, style: const TextStyle(color: Colors.white70)),
                const SizedBox(width: 6),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
