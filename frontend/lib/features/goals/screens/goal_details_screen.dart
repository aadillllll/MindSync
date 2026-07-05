import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/goal_model.dart';
import '../providers/goal_provider.dart';
import 'edit_goal_screen.dart';

class GoalDetailsScreen extends StatelessWidget {
  final GoalModel goal;

  const GoalDetailsScreen({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<GoalProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),

      appBar: AppBar(
        title: const Text("Goal Details"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              goal.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),
            if (goal.description != null &&
                goal.description!.trim().isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF182135),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white10),
                ),
                child: Text(
                  goal.description!,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF182135),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Progress",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 18),

                  LinearProgressIndicator(
                    value: goal.progressValue.clamp(0.0, 1.0),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(100),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "${goal.progress} / ${goal.target}",
                    style: const TextStyle(color: Colors.white70, fontSize: 15),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "${goal.progressPercentage}% Completed",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF182135),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Color(0xFF8B5CF6)),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Text(
                      goal.deadline == null
                          ? "No Deadline"
                          : "${goal.deadline!.day}/${goal.deadline!.month}/${goal.deadline!.year}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text("Edit Goal"),
                onPressed: () async {
                  final updated = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditGoalScreen(goal: goal),
                    ),
                  );

                  if (!context.mounted) return;

                  if (updated == true) {
                    await provider.loadGoals();

                    Navigator.pop(context);
                  }
                },
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle),
                label: const Text("Mark Completed"),
                onPressed: goal.completed
                    ? null
                    : () async {
                        await provider.completeGoal(goal.id);

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                icon: const Icon(Icons.delete),
                label: const Text("Delete Goal"),
                onPressed: () async {
                  await provider.deleteGoal(goal.id);

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
