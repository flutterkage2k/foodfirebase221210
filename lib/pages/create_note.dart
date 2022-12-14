import 'package:flutter/material.dart';
import 'package:foodfirebase221210/auth/db_service.dart';
import 'package:foodfirebase221210/pages/home_page.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({Key? key}) : super(key: key);

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: title,
                        decoration: const InputDecoration(
                          label: Text('Note title'),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Title is empty';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: body,
                        maxLines: 8,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'body is empty';
                          }
                        },
                        decoration: const InputDecoration(label: Text("Note body"), border: OutlineInputBorder()),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (key.currentState!.validate()) {
            DbHelper().add(title: title.text.trim(), body: body.text.trim()).then(
              (value) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
              },
            );
          }
          Navigator.pop(context);
        },
        label: Row(
          children: [
            Icon(Icons.add),
            Text("Save note"),
          ],
        ),
      ),
    );
  }
}
