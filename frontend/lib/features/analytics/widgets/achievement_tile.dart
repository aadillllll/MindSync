import 'package:flutter/material.dart';

class AchievementTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final bool unlocked;

  const AchievementTile({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.unlocked,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF182135),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: unlocked
              ? Colors.amber.withValues(alpha: .35)
              : Colors.white10,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: unlocked
                  ? Colors.amber.withValues(alpha: .18)
                  : Colors.white.withValues(alpha: .06),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              unlocked ? icon : Icons.lock_outline_rounded,
              color: unlocked ? Colors.amber : Colors.white38,
              size: 28,
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
                    color: unlocked ? Colors.white : Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: TextStyle(
                    color: unlocked ? Colors.white70 : Colors.white38,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: unlocked
                ? Container(
                    key: const ValueKey("achieved"),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: .18),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "ACHIEVED",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .8,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.lock_rounded,
                    key: ValueKey("locked"),
                    color: Colors.white30,
                  ),
          ),
        ],
      ),
    );
  }
}
