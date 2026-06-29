import 'package:flutter/material.dart';

class ProgressRing extends StatelessWidget {
  final int percentage;
  final double progress;

  const ProgressRing({
    super.key,
    required this.percentage,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 150,
        height: 150,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 12,
                backgroundColor: Colors.white12,
                valueColor: const AlwaysStoppedAnimation(Color(0xFF7C5CFF)),
              ),
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$percentage%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  "Productivity",
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
