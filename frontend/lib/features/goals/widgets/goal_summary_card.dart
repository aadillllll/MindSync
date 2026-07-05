import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/goal_provider.dart';

class GoalSummaryCard extends StatelessWidget {
  const GoalSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GoalProvider>();

    final completion = provider.completionRate;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF24124D), Color(0xFF1A1238)],
        ),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "You're making progress! 🚀",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "${provider.completedGoals} of ${provider.totalGoals} goals completed",
                  style: const TextStyle(color: Colors.white70, fontSize: 15),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    _stat(
                      value: provider.totalGoals.toString(),
                      label: "Total",
                    ),

                    const SizedBox(width: 18),

                    _stat(
                      value: provider.activeGoals.toString(),
                      label: "Active",
                    ),

                    const SizedBox(width: 18),

                    _stat(
                      value: provider.completedGoals.toString(),
                      label: "Done",
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          SizedBox(
            width: 88,
            height: 88,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 88,
                  height: 88,
                  child: CircularProgressIndicator(
                    value: completion,
                    strokeWidth: 8,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF8B5CF6)),
                  ),
                ),

                Text(
                  "${(completion * 100).round()}%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat({required String value, required String label}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white60, fontSize: 13),
        ),
      ],
    );
  }
}
