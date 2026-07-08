import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';
import '../providers/note_provider.dart';

class EditNoteScreen extends StatefulWidget {
  final NoteModel note;

  const EditNoteScreen({super.key, required this.note});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  late String category;

  final categories = const ["General", "Study", "Work", "Ideas", "Personal"];

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.note.title);

    contentController = TextEditingController(text: widget.note.content);

    category = widget.note.category;
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final updated = widget.note.copyWith(
      title: titleController.text.trim(),
      content: contentController.text.trim(),
      category: category,
    );

    await context.read<NoteProvider>().updateNote(updated);

    if (!mounted) return;

    Navigator.pop(context);
  }

  Future<void> _delete() async {
    await context.read<NoteProvider>().deleteNote(widget.note.id);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
        actions: [
          IconButton(icon: const Icon(Icons.delete), onPressed: _delete),
          TextButton(onPressed: _save, child: const Text("SAVE")),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: category,
              items: categories
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => category = v!),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: contentController,
              maxLines: 15,
              decoration: const InputDecoration(
                labelText: "Content",
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
