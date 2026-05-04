import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../widgets/note_card.dart';
import 'note_editor_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ghi chú")),
      body: Consumer<NoteProvider>(
        builder: (context, provider, child) {
          if (provider.notes.isEmpty) return const Center(child: Text("Trống"));
          return ListView.builder(
            itemCount: provider.notes.length,
            itemBuilder: (context, index) => NoteCard(note: provider.notes[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NoteEditorScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}