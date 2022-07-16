// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNotePage({Key? key, required this.isUpdate, this.note})
      : super(key: key);

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  FocusNode noteFocus = FocusNode();

  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  void addNewNote() {
    Note newNotes = Note(
      id: const Uuid().v1(),
      userid: "emranhasan",
      title: titleController.text,
      content: notesController.text,
      dateadded: DateTime.now(),
    );

    Provider.of<NotesProvider?>(context, listen: false)!.addNote(newNotes);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = notesController.text;
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      notesController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF080713),
        actions: [
          IconButton(
              onPressed: () {
                // ignore: unnecessary_null_comparison
                if (titleController.text.isNotEmpty &&
                    notesController.text.isNotEmpty) {
                  if (widget.isUpdate) {
                    updateNote();
                  } else {
                    addNewNote();
                  }
                } else {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              autofocus: (widget.isUpdate == true) ? false : true,
              onSubmitted: (val) {
                if (val != "") {
                  noteFocus.requestFocus();
                }
              },
              style: const TextStyle(fontSize: 30, color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(
                  color: Color.fromARGB(129, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
              ),
            ),
            Expanded(
              child: TextField(
                controller: notesController,
                focusNode: noteFocus,
                maxLines: null,
                style: const TextStyle(fontSize: 20, color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Note",
                  hintStyle: TextStyle(
                    color: Color.fromARGB(129, 255, 255, 255),
                  ),
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
