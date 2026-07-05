import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/goal_provider.dart';

import '../widgets/add_goal_button.dart';
import '../widgets/empty_goals.dart';
import '../widgets/goal_card.dart';
import '../widgets/goal_summary_card.dart';

import 'create_goal_screen.dart';
import 'edit_goal_screen.dart';
import 'goal_details_screen.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GoalProvider>().loadGoals();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GoalProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1120),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Goals",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      floatingActionButton: AddGoalButton(
        onPressed: () async {
          final created = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateGoalScreen()),
          );

          if (!mounted) return;

          if (created == true) {
            await context.read<GoalProvider>().loadGoals();
          }
        },
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: provider.loadGoals,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
                children: [
                  const GoalSummaryCard(),

                  const SizedBox(height: 28),

                  if (provider.goals.isEmpty)
                    const EmptyGoals()
                  else
                    ...provider.goals.map(
                      (goal) => Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: GoalCard(
                          goal: goal,

                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => GoalDetailsScreen(goal: goal),
                              ),
                            );

                            if (!mounted) return;

                            await context.read<GoalProvider>().loadGoals();
                          },

                          onEdit: () async {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditGoalScreen(goal: goal),
                              ),
                            );

                            if (!mounted) return;

                            if (updated == true) {
                              await context.read<GoalProvider>().loadGoals();
                            }
                          },

                          onComplete: () async {
                            final success = await provider.completeGoal(
                              goal.id,
                            );

                            if (!mounted) return;

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Goal marked as completed."),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
