import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String time;
  final String location;
  final Color color;

  /// NEW
  final bool isCompleted;

  const EventCard({
    super.key,
    required this.title,
    required this.time,
    required this.location,
    required this.color,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF182135),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 65,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  location,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.schedule_rounded,
                color: isCompleted ? Colors.green : Colors.white70,
                size: 20,
              ),

              const SizedBox(height: 6),

              Text(
                isCompleted ? "Completed" : time,
                style: TextStyle(
                  color: isCompleted ? Colors.green : color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
