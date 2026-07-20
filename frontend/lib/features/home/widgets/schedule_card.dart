import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../calendar/models/calendar_event.dart';

class ScheduleCard extends StatelessWidget {
  final CalendarEvent event;
  final bool isLast;

  const ScheduleCard({super.key, required this.event, this.isLast = false});

  Color _getColor(String color) {
    switch (color.toLowerCase()) {
      case 'purple':
        return Colors.purple;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      case 'red':
        return Colors.red;
      case 'pink':
        return Colors.pink;
      case 'teal':
        return Colors.teal;
      case 'indigo':
        return Colors.indigo;
      case 'blue':
      default:
        return Colors.blue;
    }
  }

  String _getTime() {
    if (event.isAllDay) {
      return "All Day";
    }

    final formatter = DateFormat('hh:mm a');

    return formatter.format(event.startDateTime);
  }

  String _getSubtitle() {
    if (event.location != null && event.location!.trim().isNotEmpty) {
      return event.location!;
    }

    if (event.category.trim().isNotEmpty) {
      return event.category;
    }

    return "No location";
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor(event.color);

    return SizedBox(
      height: 78,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 72,
            child: Text(
              _getTime(),
              style: AppTextStyles.body.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: color.withValues(alpha: 0.4),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: AppTextStyles.title.copyWith(fontSize: 17),
                ),

                const SizedBox(height: 4),

                Text(_getSubtitle(), style: AppTextStyles.bodySecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
