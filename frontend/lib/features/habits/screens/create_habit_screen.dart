import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/habit_model.dart';
import '../providers/habit_provider.dart';

class CreateHabitScreen extends StatefulWidget {
  const CreateHabitScreen({super.key});

  @override
  State<CreateHabitScreen> createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  String _icon = "check_circle_outline";
  String _color = "#4CAF50";

  final List<String> _days = [];

  final List<String> weekDays = const [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) return;

    final habit = HabitModel(
      id: const Uuid().v4(),
      userId: user.id,
      title: _titleController.text.trim(),
      icon: _icon,
      color: _color,
      frequencyDays: _days,
      currentStreak: 0,
      longestStreak: 0,
      createdAt: DateTime.now(),
    );

    final success = await context.read<HabitProvider>().createHabit(habit);

    if (!mounted) return;

    if (success) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Habit")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Habit Name",
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return "Enter habit name";
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            const Text(
              "Repeat On",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              children: weekDays.map((day) {
                final selected = _days.contains(day);

                return FilterChip(
                  label: Text(day),
                  selected: selected,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        _days.add(day);
                      } else {
                        _days.remove(day);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 55,
              child: FilledButton(
                onPressed: _save,
                child: const Text(
                  "Create Habit",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
