import 'package:flutter/material.dart';

class HomeHabitItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool completed;
  final int streak;

  const HomeHabitItem({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.completed,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: completed
                  ? color.withValues(alpha: .18)
                  : Colors.white.withValues(alpha: .05),
              border: Border.all(
                color: completed ? color : Colors.white24,
                width: 2,
              ),
            ),
            child: Icon(
              completed ? Icons.check : icon,
              color: completed ? color : Colors.white70,
              size: 24,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.local_fire_department,
                size: 14,
                color: Colors.orange,
              ),
              const SizedBox(width: 2),
              Text(
                "$streak",
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: completed
                  ? Colors.green.withValues(alpha: .15)
                  : Colors.orange.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              completed ? "Done" : "Pending",
              style: TextStyle(
                color: completed ? Colors.green : Colors.orange,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
