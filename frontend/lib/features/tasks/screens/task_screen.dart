import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../widgets/task_card.dart';
import 'create_task_screen.dart';
import 'task_details_screen.dart';
import '../widgets/task_summary_card.dart';

enum TaskFilter { all, today, upcoming, completed }

class TasksScreen extends StatefulWidget {
  final TaskFilter filter;

  const TasksScreen({super.key, this.filter = TaskFilter.all});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = "";

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

  String get _screenTitle {
    switch (widget.filter) {
      case TaskFilter.today:
        return "Today's Tasks";

      case TaskFilter.upcoming:
        return "Upcoming Deadlines";

      case TaskFilter.completed:
        return "Completed Tasks";

      case TaskFilter.all:
        return "My Tasks";
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    final now = DateTime.now();

    var filteredTasks = provider.tasks.where((task) {
      switch (widget.filter) {
        case TaskFilter.today:
          if (task.isCompleted) return false;
          if (task.dueDate == null) return false;

          return task.dueDate!.year == now.year &&
              task.dueDate!.month == now.month &&
              task.dueDate!.day == now.day;

        case TaskFilter.upcoming:
          if (task.isCompleted) return false;
          if (task.dueDate == null) return false;

          return task.dueDate!.isAfter(now);

        case TaskFilter.completed:
          return task.isCompleted;

        case TaskFilter.all:
          return true;
      }
    }).toList();

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();

      filteredTasks = filteredTasks.where((task) {
        return task.title.toLowerCase().contains(query) ||
            (task.description ?? "").toLowerCase().contains(query);
      }).toList();
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1120),
        elevation: 0,
        centerTitle: true,
        title: Text(
          _screenTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
          : filteredTasks.isEmpty
          ? RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                children: [
                  const SizedBox(height: 140),

                  const Icon(Icons.task_alt, color: Colors.white24, size: 80),

                  const SizedBox(height: 20),

                  Center(
                    child: Text(
                      widget.filter == TaskFilter.all
                          ? "No Tasks Yet"
                          : "No Tasks Found",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Center(
                    child: Text(
                      widget.filter == TaskFilter.all
                          ? "Tap the + button to create your first task."
                          : "Nothing matches this view right now.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  if (widget.filter == TaskFilter.all) ...[
                    const TaskSummaryCard(),
                    const SizedBox(height: 20),
                  ],

                  TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search tasks...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: const Color(0xFF182135),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const SizedBox(height: 24),

                  ...filteredTasks.map(
                    (task) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TaskCard(
                        task: task,
                        onTap: () async {
                          final updated = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskDetailsScreen(task: task),
                            ),
                          );

                          if (updated == true && mounted) {
                            await context.read<TaskProvider>().loadTasks();
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
