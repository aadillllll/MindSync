import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/habit_provider.dart';
import '../widgets/empty_habits.dart';
import '../widgets/habit_card.dart';
import '../widgets/habit_streak_card.dart';
import '../widgets/habit_summary_card.dart';
import 'create_habit_screen.dart';
import 'habit_details_screen.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HabitProvider>().loadHabits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Habits"), centerTitle: true),

      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Habit"),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateHabitScreen()),
          );

          if (!mounted) return;

          context.read<HabitProvider>().loadHabits();
        },
      ),

      body: Consumer<HabitProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.habits.isEmpty) {
            return EmptyHabits(
              onAddHabit: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateHabitScreen()),
                );

                if (!mounted) return;

                context.read<HabitProvider>().loadHabits();
              },
            );
          }

          int longest = 0;

          for (final habit in provider.habits) {
            if (habit.longestStreak > longest) {
              longest = habit.longestStreak;
            }
          }

          return RefreshIndicator(
            onRefresh: provider.loadHabits,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
              children: [
                const HabitSummaryCard(),

                const SizedBox(height: 20),

                HabitStreakCard(currentStreak: longest, longestStreak: longest),

                const SizedBox(height: 24),

                const Text(
                  "Today's Habits",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                ...provider.habits.map(
                  (habit) => HabitCard(
                    habit: habit,

                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HabitDetailsScreen(habit: habit),
                        ),
                      );

                      if (!mounted) return;

                      provider.loadHabits();
                    },

                    onComplete: () async {
                      final success = await provider.completeHabit(habit);

                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            success
                                ? "${habit.title} completed 🎉"
                                : "Unable to complete habit",
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
