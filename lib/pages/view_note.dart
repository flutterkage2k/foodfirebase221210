import 'package:flutter/material.dart';
import 'package:foodfirebase221210/pages/update_note.dart';

class ViewNotePage extends StatefulWidget {
  ViewNotePage({Key? key, this.id, this.title, this.body}) : super(key: key);

  String? id;
  String? title;
  String? body;

  @override
  State<ViewNotePage> createState() => _ViewNotePageState();
}

class _ViewNotePageState extends State<ViewNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View note'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              widget.title!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 34,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.body!),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => UpdateNotePage(
                        title: widget.title,
                        body: widget.body,
                        id: widget.id,
                      )));
        },
        label: Row(
          children: [Icon(Icons.edit), Text("Edit note")],
        ),
      ),
    );
  }
}
