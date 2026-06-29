import 'package:flutter/material.dart';

class AnalyticsHeader extends StatelessWidget {
  const AnalyticsHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .06),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("This Week", style: TextStyle(color: Colors.white70)),
              SizedBox(width: 6),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white70,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
