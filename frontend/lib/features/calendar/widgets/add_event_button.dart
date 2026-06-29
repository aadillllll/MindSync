import 'package:flutter/material.dart';

class AddEventButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddEventButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: const Color(0xFF7C5CFF),
      elevation: 10,
      child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
    );
  }
}
