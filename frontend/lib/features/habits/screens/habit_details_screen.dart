import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/habit_model.dart';
import '../providers/habit_provider.dart';
import '../services/habit_service.dart';
import 'edit_habit_screen.dart';

class HabitDetailsScreen extends StatefulWidget {
  final HabitModel habit;

  const HabitDetailsScreen({super.key, required this.habit});

  @override
  State<HabitDetailsScreen> createState() => _HabitDetailsScreenState();
}

class _HabitDetailsScreenState extends State<HabitDetailsScreen> {
  final HabitService _service = HabitService();

  bool _completedToday = false;
  int _completionCount = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _completedToday = await _service.isCompletedToday(widget.habit.id);

    _completionCount = await _service.getCompletionCount(widget.habit.id);

    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _completeHabit() async {
    await context.read<HabitProvider>().completeHabit(widget.habit);

    await _load();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Habit completed 🎉")));
  }

  @override
  Widget build(BuildContext context) {
    final habit = widget.habit;

    return Scaffold(
      appBar: AppBar(
        title: Text(habit.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditHabitScreen(habit: habit),
                ),
              );

              if (!mounted) return;

              context.read<HabitProvider>().loadHabits();
            },
          ),
        ],
      ),

      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          size: 70,
                          color: Colors.orange,
                        ),

                        const SizedBox(height: 16),

                        Text(
                          habit.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _StatCard(
                              title: "Current",
                              value: "${habit.currentStreak}",
                            ),
                            _StatCard(
                              title: "Best",
                              value: "${habit.longestStreak}",
                            ),
                            _StatCard(
                              title: "Completed",
                              value: "$_completionCount",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                FilledButton.icon(
                  onPressed: _completedToday ? null : _completeHabit,
                  icon: Icon(_completedToday ? Icons.check : Icons.done),
                  label: Text(
                    _completedToday ? "Completed Today" : "Mark Complete",
                  ),
                ),
              ],
            ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(title),
      ],
    );
  }
}
