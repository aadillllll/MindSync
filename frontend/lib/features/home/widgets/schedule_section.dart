import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/glass_card.dart';

import '../../calendar/screens/all_events_screen.dart';
import '../../calendar/screens/event_details_screen.dart';
import '../providers/dashboard_provider.dart';
import 'schedule_card.dart';

class ScheduleSection extends StatelessWidget {
  const ScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.watch<DashboardProvider>();
    final events = dashboardProvider.dashboard?.todayEvents ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Today's Schedule",
              style: AppTextStyles.title.copyWith(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AllEventsScreen()),
                );
              },
              child: const Text("View all"),
            ),
          ],
        ),

        const SizedBox(height: 12),

        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (events.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      "No events scheduled for today.",
                      style: AppTextStyles.bodySecondary,
                    ),
                  ),
                )
              else
                ...List.generate(events.length, (index) {
                  final event = events[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventDetailsScreen(event: event),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: ScheduleCard(
                        event: event,
                        isLast: index == events.length - 1,
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ],
    );
  }
}
