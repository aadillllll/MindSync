import 'package:flutter/material.dart';

class GoalProgress extends StatelessWidget {
  final double progress;
  final Color color;
  final double height;

  const GoalProgress({
    super.key,
    required this.progress,
    this.color = const Color(0xFF8B5CF6),
    this.height = 8,
  });

  @override
  Widget build(BuildContext context) {
    final value = progress.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 700),
        tween: Tween(begin: 0, end: value),
        builder: (context, value, _) {
          return LinearProgressIndicator(
            value: value,
            minHeight: height,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation(color),
          );
        },
      ),
    );
  }
}
