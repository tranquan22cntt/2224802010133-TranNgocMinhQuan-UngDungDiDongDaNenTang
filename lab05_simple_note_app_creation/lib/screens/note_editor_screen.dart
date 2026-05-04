import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;
  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Biên tập")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: "Tiêu đề")),
            Expanded(child: TextField(controller: _contentController, maxLines: null, decoration: const InputDecoration(labelText: "Nội dung"))),
            ElevatedButton(
              onPressed: () {
                final note = Note(
                  id: widget.note?.id,
                  title: _titleController.text,
                  content: _contentController.text,
                  createdAt: widget.note?.createdAt ?? DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                if (widget.note == null) {
                  context.read<NoteProvider>().addNote(note);
                } else {
                  context.read<NoteProvider>().updateNote(note);
                }
                Navigator.pop(context);
              },
              child: const Text("Lưu"),
            )
          ],
        ),
      ),
    );
  }
}