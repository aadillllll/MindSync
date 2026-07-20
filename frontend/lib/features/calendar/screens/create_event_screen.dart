import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/calendar_event.dart';
import '../providers/calendar_provider.dart';
import '../../tasks/screens/create_task_screen.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  bool _isSaving = false;
  bool _isAllDay = false;

  DateTime _startDateTime = DateTime.now();

  DateTime _endDateTime = DateTime.now().add(const Duration(hours: 1));

  String _selectedCategory = 'Personal';

  String _selectedColor = 'blue';

  final List<String> _categories = const [
    'Personal',
    'Work',
    'Study',
    'Meeting',
    'Health',
    'Other',
  ];

  final List<String> _colors = const [
    'blue',
    'purple',
    'green',
    'orange',
    'red',
    'pink',
    'teal',
    'indigo',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateTaskScreen()),
                );
              },
              child: const Text(
                "Create Task",
                style: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(width: 24),

            GestureDetector(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Create Event",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    height: 2,
                    width: 90,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ============================
                // Event Title
                // ============================
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: "Event Title",
                    hintText: "Enter event title",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter an event title";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // ============================
                // Description
                // ============================
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    hintText: "Optional description",
                    alignLabelWithHint: true,
                  ),
                ),

                const SizedBox(height: 20),

                // ============================
                // Category
                // ============================
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(labelText: "Category"),
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                // ============================
                // Location
                // ============================
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: "Location",
                    hintText: "Optional location",
                  ),
                ),

                const SizedBox(height: 24),

                // ============================
                // Color
                // ============================
                const Text(
                  "Event Color",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _colors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: _getColor(color),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedColor == color
                                ? Colors.black
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: _selectedColor == color
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // ============================
                // All Day
                // ============================
                SwitchListTile(
                  value: _isAllDay,
                  title: const Text("All Day Event"),
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    setState(() {
                      _isAllDay = value;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // ============================
                // Start Date & Time
                // ============================
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.schedule),
                  title: const Text("Start"),
                  subtitle: Text(
                    "${_startDateTime.day}/${_startDateTime.month}/${_startDateTime.year} • "
                    "${TimeOfDay.fromDateTime(_startDateTime).format(context)}",
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: _pickStartDateTime,
                ),

                const Divider(),

                // ============================
                // End Date & Time
                // ============================
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event_available),
                  title: const Text("End"),
                  subtitle: Text(
                    "${_endDateTime.day}/${_endDateTime.month}/${_endDateTime.year} • "
                    "${TimeOfDay.fromDateTime(_endDateTime).format(context)}",
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: _pickEndDateTime,
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _saveEvent,
                    child: _isSaving
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text("Save Event"),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // Pick Start Date & Time
  // =========================================================

  Future<void> _pickStartDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    TimeOfDay time = TimeOfDay.fromDateTime(_startDateTime);

    if (!_isAllDay) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: time,
      );

      if (pickedTime == null) return;

      time = pickedTime;
    } else {
      time = const TimeOfDay(hour: 0, minute: 0);
    }

    setState(() {
      _startDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );

      if (_endDateTime.isBefore(_startDateTime)) {
        _endDateTime = _startDateTime.add(const Duration(hours: 1));
      }
    });
  }

  // =========================================================
  // Pick End Date & Time
  // =========================================================

  Future<void> _pickEndDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _endDateTime,
      firstDate: _startDateTime,
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    TimeOfDay time = TimeOfDay.fromDateTime(_endDateTime);

    if (!_isAllDay) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: time,
      );

      if (pickedTime == null) return;

      time = pickedTime;
    } else {
      time = const TimeOfDay(hour: 23, minute: 59);
    }

    setState(() {
      _endDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
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
  // Save Event
  // =========================================================

  Future<void> _saveEvent() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_endDateTime.isBefore(_startDateTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End time must be after the start time.')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final provider = context.read<CalendarProvider>();

      final event = CalendarEvent(
        id: '',
        userId: '',
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
        location: _locationController.text.trim(),
        color: _selectedColor,
        startDateTime: _startDateTime,
        endDateTime: _endDateTime,
        isAllDay: _isAllDay,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final success = await provider.createEvent(event);

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event created successfully.')),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create event.')),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}
