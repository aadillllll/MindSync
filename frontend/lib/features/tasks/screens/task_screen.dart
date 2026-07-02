import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../widgets/task_card.dart';
import 'create_task_screen.dart';
import 'task_details_screen.dart';
import '../widgets/task_summary_card.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    final filteredTasks = provider.tasks.where((task) {
      if (_searchQuery.isEmpty) return true;

      final query = _searchQuery.toLowerCase();

      return task.title.toLowerCase().contains(query) ||
          (task.description ?? "").toLowerCase().contains(query);
    }).toList();

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
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const TaskSummaryCard(),

                  const SizedBox(height: 20),

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
