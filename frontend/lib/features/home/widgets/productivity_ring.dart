import 'package:flutter/material.dart';

class ProductivityRing extends StatelessWidget {
  final double progress;
  final int percentage;

  const ProductivityRing({
    super.key,
    required this.progress,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 10,
              backgroundColor: Colors.white.withOpacity(.08),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF7C5CFF)),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 2),

              const Text(
                "Productive",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
