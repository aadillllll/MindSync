import 'package:flutter/material.dart';

class ProductivityInfo extends StatelessWidget {
  final int percentage;
  final String message;

  const ProductivityInfo({
    super.key,
    required this.percentage,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final bool positive = percentage >= 70;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Productivity Score",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          message,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),

        const SizedBox(height: 30),

        Row(
          children: [
            Icon(
              positive
                  ? Icons.trending_up_rounded
                  : Icons.trending_down_rounded,
              color: positive ? Colors.greenAccent : Colors.orangeAccent,
              size: 36,
            ),

            const SizedBox(width: 14),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$percentage%",
                  style: TextStyle(
                    color: positive ? Colors.greenAccent : Colors.orangeAccent,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Text(
                  "Current productivity",
                  style: TextStyle(color: Colors.white60, fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
