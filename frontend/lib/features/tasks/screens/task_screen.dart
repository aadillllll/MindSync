import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import 'create_task_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Tasks"), centerTitle: true),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateTaskScreen()),
          );

          if (!mounted) return;

          context.read<TaskProvider>().loadTasks();
        },
        child: const Icon(Icons.add),
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.tasks.isEmpty
          ? const Center(
              child: Text("No Tasks Yet", style: TextStyle(fontSize: 18)),
            )
          : RefreshIndicator(
              onRefresh: provider.refresh,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: provider.tasks.length,
                itemBuilder: (context, index) {
                  final task = provider.tasks[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),

                    child: ListTile(
                      title: Text(task.title),

                      subtitle: Text(task.description ?? "No Description"),

                      trailing: Text(task.priority ?? ""),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
