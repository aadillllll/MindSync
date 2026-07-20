import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/calendar_event.dart';
import '../providers/calendar_provider.dart';

class EditEventScreen extends StatefulWidget {
  final CalendarEvent event;

  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _locationController;

  bool _isSaving = false;
  bool _isAllDay = false;

  late DateTime _startDateTime;
  late DateTime _endDateTime;

  late String _selectedCategory;
  late String _selectedColor;

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
  void initState() {
    super.initState();

    final event = widget.event;

    _titleController = TextEditingController(text: event.title);

    _descriptionController = TextEditingController(
      text: event.description ?? '',
    );

    _locationController = TextEditingController(text: event.location ?? '');

    _selectedCategory = event.category;
    _selectedColor = event.color;

    _startDateTime = event.startDateTime;
    _endDateTime = event.endDateTime;

    _isAllDay = event.isAllDay;
  }

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
      appBar: AppBar(title: const Text("Edit Event"), centerTitle: true),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =====================================
                // Event Title
                // =====================================
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

                // =====================================
                // Description
                // =====================================
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

                // =====================================
                // Category
                // =====================================
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

                // =====================================
                // Location
                // =====================================
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: "Location",
                    hintText: "Optional location",
                  ),
                ),

                const SizedBox(height: 24),

                // =====================================
                // Event Color
                // =====================================
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

                // =====================================
                // All Day Event
                // =====================================
                SwitchListTile(
                  value: _isAllDay,
                  contentPadding: EdgeInsets.zero,
                  title: const Text("All Day Event"),
                  onChanged: (value) {
                    setState(() {
                      _isAllDay = value;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // =====================================
                // Start Date & Time
                // =====================================
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.schedule),
                  title: const Text("Starts"),
                  subtitle: Text(
                    "${_startDateTime.day}/${_startDateTime.month}/${_startDateTime.year} • "
                    "${TimeOfDay.fromDateTime(_startDateTime).format(context)}",
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: _pickStartDateTime,
                ),

                const Divider(),

                // =====================================
                // End Date & Time
                // =====================================
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event_available),
                  title: const Text("Ends"),
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
                    onPressed: _isSaving ? null : _updateEvent,
                    child: _isSaving
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text("Update Event"),
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
  // Update Event
  // =========================================================

  Future<void> _updateEvent() async {
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
      final updatedEvent = widget.event.copyWith(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
        location: _locationController.text.trim(),
        color: _selectedColor,
        startDateTime: _startDateTime,
        endDateTime: _endDateTime,
        isAllDay: _isAllDay,
        updatedAt: DateTime.now(),
      );

      final success = await context.read<CalendarProvider>().updateEvent(
        updatedEvent,
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event updated successfully.')),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update event.')),
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
