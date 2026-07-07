import 'package:flutter/material.dart';

class HabitCompletionHistory extends StatelessWidget {
  final List<DateTime> history;

  const HabitCompletionHistory({super.key, required this.history});

  bool _completed(int dayOffset) {
    final today = DateTime.now();

    final day = DateTime(
      today.year,
      today.month,
      today.day,
    ).subtract(Duration(days: dayOffset));

    return history.any(
      (d) => d.year == day.year && d.month == day.month && d.day == day.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    const labels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Container(
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
            "This Week",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final completed = _completed(6 - index);

              return Column(
                children: [
                  Text(
                    labels[index],
                    style: const TextStyle(color: Colors.white60, fontSize: 12),
                  ),

                  const SizedBox(height: 10),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: completed
                          ? const Color(0xFF8B5CF6)
                          : Colors.white12,
                      shape: BoxShape.circle,
                    ),
                    child: completed
                        ? const Icon(Icons.check, size: 12, color: Colors.white)
                        : null,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
