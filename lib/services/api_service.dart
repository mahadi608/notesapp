// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:developer';

import 'package:notesapp/models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String BaseUrl = "https://still-beach-21226.herokuapp.com/notes";
  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse("$BaseUrl/add");
    var response = await http.post(requestUri,
        body: note.toMap(), headers: {'Accept': 'application/json'});
    var decodejson = jsonDecode(response.body);
    log(decodejson.toString());
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse("$BaseUrl/delete");
    var response = await http.post(requestUri,
        body: note.toMap(), headers: {'Accept': 'application/json'});
    var decodejson = jsonDecode(response.body);
    log(decodejson.toString());
  }

  static Future<List<Note>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse("$BaseUrl/list/user");
    var response = await http.post(requestUri, body: {"userid": userid});
    var decodejson = jsonDecode(response.body);
    List<Note> notes = [];
    for (var noteMap in decodejson) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }
    return notes;
  }
}
