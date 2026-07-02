import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF182135),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item("Total", provider.totalTasks.toString(), Colors.blue),
          _item("Pending", provider.pendingCount.toString(), Colors.orange),
          _item("Completed", provider.completedCount.toString(), Colors.green),
          _item(
            "High",
            provider.highPriorityTasks.length.toString(),
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _item(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
