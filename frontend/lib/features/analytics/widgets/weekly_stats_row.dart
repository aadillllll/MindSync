import 'package:flutter/material.dart';

class WeeklyStatsRow extends StatelessWidget {
  final int goals;
  final double focusHours;

  const WeeklyStatsRow({
    super.key,
    required this.goals,
    required this.focusHours,
  });

  Widget _buildStat({
    required IconData icon,
    required Color color,
    required String value,
    required String title,
  }) {
    return Expanded(
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withValues(alpha: .15),
            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                title,
                style: const TextStyle(color: Colors.white60, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStat(
          icon: Icons.flag_rounded,
          color: Colors.deepPurpleAccent,
          value: goals.toString(),
          title: "Goals",
        ),

        const SizedBox(width: 24),

        _buildStat(
          icon: Icons.schedule_rounded,
          color: Colors.blueAccent,
          value: "${focusHours.toStringAsFixed(1)}h",
          title: "Focus Time",
        ),
      ],
    );
  }
}
