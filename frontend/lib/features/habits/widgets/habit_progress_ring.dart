import 'package:flutter/material.dart';

class HabitProgressRing extends StatelessWidget {
  final double progress;
  final double size;
  final Color color;
  final String? label;

  const HabitProgressRing({
    super.key,
    required this.progress,
    this.size = 110,
    this.color = const Color(0xFF8B5CF6),
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final value = progress.clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 700),
            tween: Tween(begin: 0, end: value),
            builder: (context, value, _) {
              return SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 10,
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              );
            },
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${(progress * 100).round()}%",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              if (label != null) ...[
                const SizedBox(height: 4),
                Text(
                  label!,
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
