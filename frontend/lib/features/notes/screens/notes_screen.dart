import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/note_provider.dart';
import '../widgets/empty_notes.dart';
import '../widgets/note_card.dart';
import '../widgets/note_search_bar.dart';
import 'create_note_screen.dart';
import 'edit_note_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NoteProvider>().loadNotes();
    });
  }

  Future<void> _refresh() async {
    await context.read<NoteProvider>().loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Notes"), centerTitle: true),

          floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: const Text("New Note"),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateNoteScreen()),
              );

              if (!mounted) return;

              _refresh();
            },
          ),

          body: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const NoteSearchBar(),

                    Expanded(
                      child: provider.displayedNotes.isEmpty
                          ? provider.searchQuery.isNotEmpty
                                ? const Center(
                                    child: Text(
                                      "No notes found",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  )
                                : EmptyNotes(
                                    onCreate: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const CreateNoteScreen(),
                                        ),
                                      );

                                      if (!mounted) return;

                                      _refresh();
                                    },
                                  )
                          : RefreshIndicator(
                              onRefresh: _refresh,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 100),
                                itemCount: provider.displayedNotes.length,
                                itemBuilder: (context, index) {
                                  final note = provider.displayedNotes[index];

                                  return NoteCard(
                                    note: note,

                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              EditNoteScreen(note: note),
                                        ),
                                      );

                                      if (!mounted) return;

                                      _refresh();
                                    },

                                    onPin: () => provider.togglePin(note),

                                    onFavorite: () =>
                                        provider.toggleFavorite(note),
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
