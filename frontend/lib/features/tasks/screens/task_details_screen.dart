import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task_model.dart';
import '../widgets/priority_chip.dart';
import '../widgets/status_chip.dart';
import 'edit_task_screen.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class TaskDetailsScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final dueDate = task.dueDate != null
        ? DateFormat('dd MMM yyyy').format(task.dueDate!)
        : "No due date";

    final createdDate = task.createdAt != null
        ? DateFormat('dd MMM yyyy').format(task.createdAt!)
        : "-";

    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1120),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Task Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                PriorityChip(priority: task.priority),
                StatusChip(status: task.status),
              ],
            ),

            const SizedBox(height: 28),

            Text(
              task.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Description",
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              task.description?.isNotEmpty == true
                  ? task.description!
                  : "No description provided.",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF182135),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  _infoRow(Icons.calendar_today_rounded, "Due Date", dueDate),

                  const Divider(color: Colors.white12),

                  _infoRow(Icons.access_time_rounded, "Created", createdDate),
                ],
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final updated = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditTaskScreen(task: task),
                    ),
                  );

                  if (updated == true && context.mounted) {
                    Navigator.pop(context, true);
                  }
                },
                icon: const Icon(Icons.edit_rounded),
                label: const Text("Edit Task"),
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () async {
                  if ((task.status ?? "").toLowerCase() == "completed") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Task is already completed."),
                      ),
                    );
                    return;
                  }

                  final provider = context.read<TaskProvider>();

                  final success = await provider.markTaskCompleted(task.id);

                  if (!context.mounted) return;

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Task marked as completed."),
                      ),
                    );

                    Navigator.pop(context, true);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to update task.")),
                    );
                  }
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text("Mark as Completed"),
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton.tonalIcon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red.withValues(alpha: 0.15),
                ),
                onPressed: () async {
                  final shouldDelete = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Delete Task"),
                        content: const Text(
                          "Are you sure you want to delete this task?\n\nThis action cannot be undone.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text("Cancel"),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldDelete != true) return;

                  final provider = context.read<TaskProvider>();

                  final success = await provider.deleteTask(task.id);

                  if (!context.mounted) return;

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Task deleted successfully."),
                      ),
                    );

                    Navigator.pop(context, true);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to delete task.")),
                    );
                  }
                },
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                label: const Text(
                  "Delete Task",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70),

        const SizedBox(width: 14),

        Expanded(
          child: Text(title, style: const TextStyle(color: Colors.white70)),
        ),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
