// NAME: Ieskandar Zulqarnain Bin Ghazali
// MATRIC NO: A20EC0046
// COURSE: SECJ3623-01(MOBILE APPLICATION PROGRAMMING)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/addnotes.dart';
import 'package:map_exam/edit_screen.dart';
import 'package:map_exam/note.dart';
import 'package:map_exam/viewNote.dart';

class HomeScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const HomeScreen());

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Note> notes = [];
  bool showLess = false;
  int? selectedNoteIndex; // Track the index of the selected note
  bool editingToolsVisible = false; // Track the visibility of editing tools

  @override
  void initState() {
    super.initState();
    fetchUserNotes();
  }

  void fetchUserNotes() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('notes')
          .where('email', isEqualTo: user.email)
          .get();

      final List<Note> userNotes = querySnapshot.docs
          .map((document) => Note.fromJson({
                ...document.data() as Map<String, dynamic>,
                'id': document.id, // Assign the document ID to the 'id' field
              }))
          .toList();

      setState(() {
        notes = userNotes;
      });
    }
  }

  void _logout() async {
    await _auth.signOut();
    Navigator.of(context).pop(); // Go back to the previous screen (LoginScreen)
  }

  void toggleShowLess() {
    setState(() {
      showLess = !showLess;
    });
  }

  void addNote() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddNotesScreen(onNoteAdded: () {
                fetchUserNotes(); // Fetch the updated notes after adding a new note
              })),
    );
  }

  void deleteNote(Note note) async {
    try {
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(note.id)
          .delete();
      fetchUserNotes(); // Fetch the updated notes after deleting a note
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to delete the note. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void editNote(Note note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditScreen(note: note)),
    );
    fetchUserNotes(); // Fetch the updated notes after editing a note
  }

  void viewNote(Note note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewNotes(note: note)),
    );
  }

  void toggleEditingTools(int index) {
    setState(() {
      if (selectedNoteIndex == index) {
        // Same note title long-pressed again
        editingToolsVisible = !editingToolsVisible;
      } else {
        // Different note title long-pressed
        selectedNoteIndex = index;
        editingToolsVisible = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _logout,
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade200,
            child: Text(
              notes.length.toString(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            trailing: SizedBox(
              width: 110.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (selectedNoteIndex == index && editingToolsVisible)
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => editNote(note),
                    ),
                  if (selectedNoteIndex == index && editingToolsVisible)
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.blue,
                      ),
                      onPressed: () => deleteNote(note),
                    ),
                ],
              ),
            ),
            title: GestureDetector(
              child: Text(note.title ?? ''),
              onLongPress: () => toggleEditingTools(index),
            ),
            subtitle: showLess ? null : Text(note.content ?? ''),
            onTap: () => viewNote(note),
            onLongPress: () => toggleEditingTools(index),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'showLess',
            child: showLess
                ? const Icon(Icons.menu)
                : const Icon(Icons.expand_circle_down),
            tooltip: showLess
                ? 'Show more. Display notes content'
                : 'Show less. Hide notes content',
            onPressed: toggleShowLess,
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            heroTag: 'addNote',
            child: const Icon(Icons.add),
            tooltip: 'Add a new note',
            onPressed: addNote,
          ),
        ],
      ),
    );
  }
}
