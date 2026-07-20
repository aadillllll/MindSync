import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/calendar_event.dart';
import '../providers/calendar_provider.dart';
import 'edit_event_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  final CalendarEvent event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late CalendarEvent event;

  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Event Details"), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==========================================
              // Event Title
              // ==========================================
              Row(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: _getColor(event.color),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ==========================================
              // Category
              // ==========================================
              _buildInfoTile(
                icon: Icons.category_outlined,
                title: "Category",
                value: event.category,
              ),

              const SizedBox(height: 16),

              // ==========================================
              // Location
              // ==========================================
              if (event.location != null && event.location!.trim().isNotEmpty)
                _buildInfoTile(
                  icon: Icons.location_on_outlined,
                  title: "Location",
                  value: event.location!,
                ),

              if (event.location != null && event.location!.trim().isNotEmpty)
                const SizedBox(height: 16),

              // ==========================================
              // Description
              // ==========================================
              if (event.description != null &&
                  event.description!.trim().isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                      ),
                      child: Text(
                        event.description!,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 24),

              // ==========================================
              // Date & Time Information
              // ==========================================
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      _buildInfoTile(
                        icon: Icons.schedule,
                        title: "Starts",
                        value: _formatDateTime(event.startDateTime),
                      ),

                      const Divider(height: 30),

                      _buildInfoTile(
                        icon: Icons.event_available,
                        title: "Ends",
                        value: _formatDateTime(event.endDateTime),
                      ),

                      const Divider(height: 30),

                      _buildInfoTile(
                        icon: Icons.timelapse,
                        title: "Duration",
                        value: _formatDuration(event.duration),
                      ),

                      const Divider(height: 30),

                      _buildInfoTile(
                        icon: Icons.today,
                        title: "All Day",
                        value: event.isAllDay ? "Yes" : "No",
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ==========================================
              // Additional Information
              // ==========================================
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      if (event.createdAt != null)
                        _buildInfoTile(
                          icon: Icons.add_circle_outline,
                          title: "Created",
                          value: _formatDate(event.createdAt!),
                        ),

                      if (event.createdAt != null && event.updatedAt != null)
                        const Divider(height: 30),

                      if (event.updatedAt != null)
                        _buildInfoTile(
                          icon: Icons.edit_calendar_outlined,
                          title: "Last Updated",
                          value: _formatDate(event.updatedAt!),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ==========================================
              // Action Buttons
              // ==========================================
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: _editEvent,
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Event"),
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: _deleteEvent,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text("Delete Event"),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // Edit Event
  // =========================================================

  Future<void> _editEvent() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditEventScreen(event: event)),
    );

    if (!mounted) return;

    await context.read<CalendarProvider>().refresh();

    final updatedEvent = await context
        .read<CalendarProvider>()
        .allEvents
        .where((e) => e.id == event.id)
        .cast<CalendarEvent?>()
        .firstOrNull;

    if (updatedEvent != null) {
      setState(() {
        event = updatedEvent;
      });
    }
  }

  // =========================================================
  // Delete Event
  // =========================================================

  Future<void> _deleteEvent() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Delete Event"),
          content: const Text("Are you sure you want to delete this event?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    final success = await context.read<CalendarProvider>().deleteEvent(
      event.id,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Event deleted successfully.")),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to delete event.")));
    }
  }

  // =========================================================
  // Helper Widget
  // =========================================================

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =========================================================
  // Color Helper
  // =========================================================

  Color _getColor(String color) {
    switch (color) {
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

  // =========================================================
  // Date Formatting
  // =========================================================

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String _formatDateTime(DateTime date) {
    final time = TimeOfDay.fromDateTime(date);

    return "${date.day}/${date.month}/${date.year} • ${time.format(context)}";
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours == 0) {
      return "$minutes min";
    }

    if (minutes == 0) {
      return "$hours hr";
    }

    return "$hours hr $minutes min";
  }
}
