import 'package:flutter/material.dart';

class AddGoalButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddGoalButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: const Color(0xFF8B5CF6),
      elevation: 8,
      child: const Icon(Icons.add_rounded, color: Colors.white),
    );
  }
}
