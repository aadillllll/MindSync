import 'package:flutter/material.dart';

class HomeHabitRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final int streak;
  final bool completed;
  final VoidCallback? onTap;

  const HomeHabitRow({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.streak,
    required this.completed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: completed
            ? Colors.green.withValues(alpha: 0.04)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
            child: Row(
              children: [
                /// Habit Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),

                const SizedBox(width: 16),

                /// Title & Streak
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Row(
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            size: 15,
                            color: Colors.orange,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            "$streak day${streak == 1 ? "" : "s"}",
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                /// Status Indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: completed
                        ? Colors.green.withValues(alpha: 0.15)
                        : Colors.transparent,
                    border: Border.all(
                      color: completed ? Colors.green : Colors.white24,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    completed
                        ? Icons.check_rounded
                        : Icons.radio_button_unchecked_rounded,
                    size: 17,
                    color: completed ? Colors.green : Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
