// NAME: Ieskandar Zulqarnain Bin Ghazali
// MATRIC NO: A20EC0046
// COURSE: SECJ3623-01(MOBILE APPLICATION PROGRAMMING)

import 'package:flutter/material.dart';
import 'package:map_exam/note.dart';

class ViewNotes extends StatefulWidget {
  final Note note;

  const ViewNotes({Key? key, required this.note}) : super(key: key);

  @override
  _ViewNotesState createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  void _cancelViewing() {
    Navigator.of(context).pop(); // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: const Text('Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.cancel_sharp,
              size: 30,
            ),
            onPressed: () {
              _cancelViewing();
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.note.title,
              enabled: false,
              style: const TextStyle(color: Colors.black), // Update text color
              decoration: const InputDecoration(
                hintText: 'Type the title here',
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: TextFormField(
                initialValue: widget.note.content,
                enabled: false,
                maxLines: null,
                expands: true,
                style:
                    const TextStyle(color: Colors.black), // Update text color
                decoration: const InputDecoration(
                  hintText: 'Type the description',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
