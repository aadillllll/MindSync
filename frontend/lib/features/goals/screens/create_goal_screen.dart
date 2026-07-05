import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/goal_model.dart';
import '../providers/goal_provider.dart';

class CreateGoalScreen extends StatefulWidget {
  const CreateGoalScreen({super.key});

  @override
  State<CreateGoalScreen> createState() => _CreateGoalScreenState();
}

class _CreateGoalScreenState extends State<CreateGoalScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _targetController = TextEditingController(text: "100");
  final _progressController = TextEditingController(text: "0");

  DateTime? _deadline;
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetController.dispose();
    _progressController.dispose();

    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        _deadline = date;
      });
    }
  }

  Future<void> _saveGoal() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<GoalProvider>();

    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) return;

    final target = int.tryParse(_targetController.text) ?? 0;
    final progress = int.tryParse(_progressController.text) ?? 0;

    final goal = GoalModel(
      id: "",
      userId: user.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      target: target,
      progress: progress,
      deadline: _deadline,
      completed: progress >= target,
    );

    final success = await provider.createGoal(goal);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Goal created successfully.")),
      );

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to create goal.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GoalProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),

      appBar: AppBar(
        title: const Text("Create Goal"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Goal Title"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter a goal title";
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
              TextFormField(
                controller: _targetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Target"),
                validator: (value) {
                  final number = int.tryParse(value ?? "");

                  if (number == null || number <= 0) {
                    return "Enter a valid target";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),
              TextFormField(
                controller: _progressController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Initial Progress",
                ),
                validator: (value) {
                  final number = int.tryParse(value ?? "");

                  if (number == null || number < 0) {
                    return "Invalid progress";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  _deadline == null
                      ? "Select Deadline"
                      : "${_deadline!.day}/${_deadline!.month}/${_deadline!.year}",
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),

              const SizedBox(height: 40),
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: provider.isLoading ? null : _saveGoal,
                  child: provider.isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Create Goal"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
