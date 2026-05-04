import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/note.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future fetchNotes() async {
    _notes = await DBHelper.instance.getAllNotes();
    notifyListeners();
  }

  Future addNote(String title, String content) async {
    final now = DateTime.now();

    final note = Note(
      title: title,
      content: content,
      createdAt: now,
      updatedAt: now,
    );

    await DBHelper.instance.insert(note);
    await fetchNotes();
  }

  Future updateNote(Note note, String title, String content) async {
    final updated = note.copyWith(
      title: title,
      content: content,
      updatedAt: DateTime.now(),
    );

    await DBHelper.instance.update(updated);
    await fetchNotes();
  }

  Future deleteNote(int id) async {
    await DBHelper.instance.delete(id);
    await fetchNotes();
  }
}