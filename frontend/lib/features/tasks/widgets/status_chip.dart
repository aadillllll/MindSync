import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String? status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final value = (status ?? 'Pending').toLowerCase();

    Color background;
    Color foreground;
    IconData icon;

    switch (value) {
      case 'completed':
        background = const Color(0xFFE8F5E9);
        foreground = const Color(0xFF2E7D32);
        icon = Icons.check_circle_rounded;
        break;

      case 'in progress':
        background = const Color(0xFFE3F2FD);
        foreground = const Color(0xFF1976D2);
        icon = Icons.timelapse_rounded;
        break;

      default:
        background = const Color(0xFFFFF3E0);
        foreground = const Color(0xFFEF6C00);
        icon = Icons.schedule_rounded;
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
            status ?? 'Pending',
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
