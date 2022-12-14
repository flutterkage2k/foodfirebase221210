import 'package:flutter/material.dart';
import 'package:foodfirebase221210/auth/db_service.dart';
import 'package:foodfirebase221210/pages/home_page.dart';
import 'package:foodfirebase221210/pages/view_note.dart';

class UpdateNotePage extends StatefulWidget {
  UpdateNotePage({Key? key, this.id, this.title, this.body}) : super(key: key);

  String? id;
  String? title;
  String? body;

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      title.text = widget.title!;
      body.text = widget.body!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Note"),
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
            DbHelper().update(id: widget.id, title: title.text.trim(), body: body.text.trim()).then(
              (value) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
              },
            );
          }
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()), (route) => false);
        },
        label: Row(
          children: [
            Icon(Icons.add),
            Text("Update note"),
          ],
        ),
      ),
    );
  }
}
