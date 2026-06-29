import 'package:flutter/material.dart';

class WeeklyChart extends StatelessWidget {
  const WeeklyChart({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      ("Mon", 0.70),
      ("Tue", 0.90),
      ("Wed", 0.55),
      ("Thu", 0.80),
      ("Fri", 1.00),
      ("Sat", 0.60),
      ("Sun", 0.85),
    ];

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: data.map((day) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOut,
                        width: 22,
                        height: 120 * day.$2 + 20,
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
                        day.$1,
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
