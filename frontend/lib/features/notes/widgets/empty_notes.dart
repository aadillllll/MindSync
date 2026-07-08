import 'package:flutter/material.dart';

class EmptyNotes extends StatelessWidget {
  final VoidCallback onCreate;

  const EmptyNotes({super.key, required this.onCreate});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.note_alt_outlined,
              size: 90,
              color: Colors.deepPurple,
            ),

            const SizedBox(height: 24),

            const Text(
              "No Notes Yet",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Text(
              "Capture your thoughts, ideas and important information.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),

            const SizedBox(height: 28),

            FilledButton.icon(
              onPressed: onCreate,
              icon: const Icon(Icons.add),
              label: const Text("Create Note"),
            ),
          ],
        ),
      ),
    );
  }
}
