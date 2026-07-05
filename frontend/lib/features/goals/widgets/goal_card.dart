import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/goal_model.dart';
import 'goal_progress.dart';

class GoalCard extends StatelessWidget {
  final GoalModel goal;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onComplete;

  const GoalCard({
    super.key,
    required this.goal,
    this.onTap,
    this.onEdit,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = goal.progressPercentage;

    Color statusColor;
    String statusText;

    if (goal.completed) {
      statusColor = Colors.green;
      statusText = "Completed";
    } else if (percentage >= 70) {
      statusColor = Colors.blue;
      statusText = "On Track";
    } else {
      statusColor = Colors.orange;
      statusText = "In Progress";
    }

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF182135),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// -----------------------------
            /// Header
            /// -----------------------------
            Row(
              children: [
                const Icon(Icons.flag_rounded, color: Color(0xFF8B5CF6)),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    goal.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            if (goal.description != null &&
                goal.description!.trim().isNotEmpty) ...[
              const SizedBox(height: 10),

              Text(
                goal.description!,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],

            const SizedBox(height: 22),

            GoalProgress(progress: goal.progressValue),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${goal.progress} / ${goal.target}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Text(
                  "$percentage%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            if (goal.deadline != null) ...[
              const SizedBox(height: 18),

              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.white60,
                  ),

                  const SizedBox(width: 8),

                  Text(
                    DateFormat("dd MMM yyyy").format(goal.deadline!),
                    style: const TextStyle(color: Colors.white60),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 22),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text("Edit"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: goal.completed ? null : onComplete,
                    icon: const Icon(Icons.check),
                    label: const Text("Complete"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
