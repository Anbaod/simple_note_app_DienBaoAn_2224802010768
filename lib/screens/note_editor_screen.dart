import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NoteProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Editor")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: InputDecoration(hintText: "Tiêu đề")),
            SizedBox(height: 10),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: InputDecoration(hintText: "Nội dung"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Lưu"),
                onPressed: () async {
                  if (titleController.text.isEmpty) return;

                  await provider.addNote(
                    titleController.text,
                    contentController.text,
                  );

                  Navigator.pop(context);
                }
            )
          ],
        ),
      ),
    );
  }
}