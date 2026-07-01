import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task_model.dart';
import 'priority_chip.dart';
import 'status_chip.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback? onTap;

  const TaskCard({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    final dueDate = task.dueDate != null
        ? DateFormat('dd MMM yyyy').format(task.dueDate!)
        : 'No due date';

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: const Color(0xFF182135),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //-------------------------------------------------
                  // Priority + Status
                  //-------------------------------------------------
                  Row(
                    children: [
                      PriorityChip(priority: task.priority),

                      const SizedBox(width: 10),

                      StatusChip(status: task.status),

                      const Spacer(),

                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white54,
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  //-------------------------------------------------
                  // Title
                  //-------------------------------------------------
                  Text(
                    task.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  if (task.description != null &&
                      task.description!.isNotEmpty) ...[
                    const SizedBox(height: 8),

                    Text(
                      task.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],

                  const SizedBox(height: 18),

                  //-------------------------------------------------
                  // Due Date
                  //-------------------------------------------------
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.white54,
                        size: 16,
                      ),

                      const SizedBox(width: 6),

                      Text(
                        dueDate,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
