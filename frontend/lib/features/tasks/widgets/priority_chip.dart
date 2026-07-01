import 'package:flutter/material.dart';

class PriorityChip extends StatelessWidget {
  final String? priority;

  const PriorityChip({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    final value = (priority ?? 'Medium').toLowerCase();

    Color background;
    Color foreground;
    IconData icon;

    switch (value) {
      case 'high':
        background = const Color(0xFFFFE5E5);
        foreground = const Color(0xFFE53935);
        icon = Icons.keyboard_double_arrow_up_rounded;
        break;

      case 'low':
        background = const Color(0xFFE8F5E9);
        foreground = const Color(0xFF43A047);
        icon = Icons.keyboard_double_arrow_down_rounded;
        break;

      default:
        background = const Color(0xFFFFF8E1);
        foreground = const Color(0xFFFFA000);
        icon = Icons.remove_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: foreground),
          const SizedBox(width: 4),
          Text(
            priority ?? "Medium",
            style: TextStyle(
              color: foreground,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
