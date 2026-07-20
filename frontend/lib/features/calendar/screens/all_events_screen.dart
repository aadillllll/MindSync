import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_background.dart';

import '../providers/calendar_provider.dart';
import '../screens/event_details_screen.dart';
import '../widgets/event_card.dart';

class AllEventsScreen extends StatefulWidget {
  const AllEventsScreen({super.key});

  @override
  State<AllEventsScreen> createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CalendarProvider>().refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalendarProvider>();

    final events = List.of(provider.allEvents)
      ..sort((a, b) => a.startDateTime.compareTo(b.startDateTime));

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "All Events",
                      style: AppTextStyles.title.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: RefreshIndicator(
                  onRefresh: provider.refresh,
                  child: events.isEmpty
                      ? ListView(
                          children: [
                            const SizedBox(height: 150),
                            Icon(
                              Icons.event_busy,
                              size: 70,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Text(
                                "No events found",
                                style: AppTextStyles.bodySecondary,
                              ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(20),
                          itemCount: events.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final event = events[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EventDetailsScreen(event: event),
                                  ),
                                );
                              },

                              child: EventCard(
                                title: event.title,
                                time: event.isAllDay
                                    ? "All Day"
                                    : DateFormat(
                                        'hh:mm a',
                                      ).format(event.startDateTime),
                                location: event.location ?? event.category,
                                color: _eventColor(event.color),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _eventColor(String color) {
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
      default:
        return Colors.blue;
    }
  }
}
