import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../widgets/task_card.dart';
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

  Future<void> _refresh() async {
    await context.read<TaskProvider>().loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1120),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Tasks",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF7C5CFF),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateTaskScreen()),
          );

          if (!mounted) return;

          await context.read<TaskProvider>().loadTasks();
        },
        child: const Icon(Icons.add),
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.tasks.isEmpty
          ? RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                children: const [
                  SizedBox(height: 140),

                  Icon(Icons.task_alt, color: Colors.white24, size: 80),

                  SizedBox(height: 20),

                  Center(
                    child: Text(
                      "No Tasks Yet",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Center(
                    child: Text(
                      "Tap the + button to create your first task.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54, fontSize: 15),
                    ),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: provider.tasks.length,
                itemBuilder: (context, index) {
                  final task = provider.tasks[index];

                  return TaskCard(
                    task: task,
                    onTap: () {
                      // Task Details Screen (Next)
                    },
                  );
                },
              ),
            ),
    );
  }
}
