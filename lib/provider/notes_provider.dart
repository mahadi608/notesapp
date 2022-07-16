import 'package:flutter/cupertino.dart';
import 'package:notesapp/services/api_service.dart';

import '../models/note.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;
  List<Note> notes = [];

  NotesProvider() {
    fetchNotes();
  }

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int indexofNotes =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexofNotes] = note;
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int indexofNotes =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexofNotes);
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await ApiService.fetchNotes("emranhasan");
    isLoading = false;
    notifyListeners();
  }
}
