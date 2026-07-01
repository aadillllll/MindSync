import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../providers/task_provider.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  late String _priority;
  late String _status;

  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.task.title);

    _descriptionController = TextEditingController(
      text: widget.task.description ?? "",
    );

    _priority = widget.task.priority ?? "Medium";
    _status = widget.task.status ?? "Pending";
    _dueDate = widget.task.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<TaskProvider>();

    final updatedTask = widget.task.copyWith(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      priority: _priority,
      status: _status,

      // Keep both fields synchronized
      isCompleted: _status == "Completed",

      dueDate: _dueDate,
      updatedAt: DateTime.now(),
    );

    final success = await provider.updateTask(updatedTask);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task updated successfully.")),
      );

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to update task.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Task")),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter a task title";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(labelText: "Description"),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: _priority,
                decoration: const InputDecoration(labelText: "Priority"),
                items: const [
                  DropdownMenuItem(value: "Low", child: Text("Low")),
                  DropdownMenuItem(value: "Medium", child: Text("Medium")),
                  DropdownMenuItem(value: "High", child: Text("High")),
                ],
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: "Status"),
                items: const [
                  DropdownMenuItem(value: "Pending", child: Text("Pending")),
                  DropdownMenuItem(
                    value: "Completed",
                    child: Text("Completed"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),

              const SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  _dueDate == null
                      ? "Select Due Date"
                      : "${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}",
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),

              const SizedBox(height: 40),

              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: provider.isLoading ? null : _saveChanges,
                  child: provider.isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Save Changes"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
