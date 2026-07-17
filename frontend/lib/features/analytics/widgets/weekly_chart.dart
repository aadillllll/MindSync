import 'package:flutter/material.dart';

import '../models/weekly_activity_model.dart';

class WeeklyChart extends StatelessWidget {
  final List<WeeklyActivityModel> activity;

  const WeeklyChart({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    double maxValue = 1;

    if (activity.isNotEmpty) {
      maxValue = activity
          .map((e) => e.total)
          .reduce((a, b) => a > b ? a : b)
          .toDouble();

      if (maxValue == 0) {
        maxValue = 1;
      }
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF182135),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Weekly Activity",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: activity.map((day) {
                final height = ((day.total / maxValue) * 120).clamp(
                  20.0,
                  140.0,
                );

                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: 22,
                        height: height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Color(0xFF7C5CFF), Color(0xFF5D7CFF)],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        day.day,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
