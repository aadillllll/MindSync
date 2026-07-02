import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback? onTap;

  const TaskCard({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isCompleted = (task.status ?? "").toLowerCase() == "completed";

    final isOverdue =
        !isCompleted &&
        task.dueDate != null &&
        task.dueDate!.isBefore(DateTime.now());

    Color priorityColor;

    switch ((task.priority ?? "").toLowerCase()) {
      case "high":
        priorityColor = Colors.red;
        break;
      case "medium":
        priorityColor = Colors.orange;
        break;
      default:
        priorityColor = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF182135),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),

                  if (isCompleted)
                    const Icon(Icons.check_circle, color: Colors.green),
                ],
              ),

              if (task.description != null && task.description!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  task.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],

              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    backgroundColor: priorityColor.withOpacity(.15),
                    label: Text(task.priority ?? "Low"),
                    labelStyle: TextStyle(
                      color: priorityColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Chip(
                    backgroundColor: isCompleted
                        ? Colors.green.withOpacity(.15)
                        : Colors.orange.withOpacity(.15),
                    label: Text(task.status ?? "Pending"),
                    labelStyle: TextStyle(
                      color: isCompleted ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  if (isOverdue)
                    Chip(
                      backgroundColor: Colors.red.withOpacity(.15),
                      label: const Text("Overdue"),
                      labelStyle: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),

              if (task.dueDate != null) ...[
                const SizedBox(height: 14),

                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.white60,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      DateFormat("dd MMM yyyy").format(task.dueDate!),
                      style: const TextStyle(color: Colors.white60),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
