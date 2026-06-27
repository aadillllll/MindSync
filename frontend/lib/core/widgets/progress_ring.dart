import 'package:flutter/material.dart';

class ProgressRing extends StatelessWidget {
  final double progress;
  final Color color;
  final String percentage;
  final IconData icon;

  const ProgressRing({
    super.key,
    required this.progress,
    required this.color,
    required this.percentage,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74,
      height: 74,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 74,
            height: 74,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 6,
              backgroundColor: Colors.white.withValues(alpha: .08),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 16),

              const SizedBox(height: 4),

              Text(
                percentage,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
