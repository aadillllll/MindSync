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

  Future<void> _refresh() async {
    await context.read<HabitProvider>().loadHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitProvider>(
      builder: (context, provider, child) {
        int bestStreak = 0;

        for (final habit in provider.habits) {
          if (habit.longestStreak > bestStreak) {
            bestStreak = habit.longestStreak;
          }
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Column(
              children: [
                const Text("Habits"),
                Text(
                  "${provider.totalHabits} Habits",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),

          floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: const Text("New Habit"),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateHabitScreen()),
              );

              if (!mounted) return;

              _refresh();
            },
          ),

          body: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : provider.habits.isEmpty
              ? EmptyHabits(
                  onAddHabit: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreateHabitScreen(),
                      ),
                    );

                    if (!mounted) return;

                    _refresh();
                  },
                )
              : RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                    children: [
                      const HabitSummaryCard(),

                      const SizedBox(height: 20),

                      HabitStreakCard(
                        currentStreak: bestStreak,
                        longestStreak: bestStreak,
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        "Today's Habits",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      ...provider.habits.map(
                        (habit) => HabitCard(
                          habit: habit,

                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    HabitDetailsScreen(habit: habit),
                              ),
                            );

                            if (!mounted) return;

                            _refresh();
                          },

                          onComplete: () async {
                            final success = await provider.completeHabit(habit);

                            if (!mounted) return;

                            if (success) {
                              _refresh();
                            }

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

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
