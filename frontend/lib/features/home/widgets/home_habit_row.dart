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
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: color.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 24),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        color: Colors.orange,
                        size: 15,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        "$streak day${streak == 1 ? "" : "s"} streak",
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

            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: completed
                    ? Colors.green.withValues(alpha: .18)
                    : Colors.white.withValues(alpha: .05),
                border: Border.all(
                  color: completed ? Colors.green : Colors.white24,
                ),
              ),
              child: Icon(
                completed ? Icons.check_rounded : Icons.radio_button_unchecked,
                size: 20,
                color: completed ? Colors.green : Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
