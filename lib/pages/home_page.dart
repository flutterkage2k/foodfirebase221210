import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodfirebase221210/auth/auth_service.dart';
import 'package:foodfirebase221210/auth/db_service.dart';
import 'package:foodfirebase221210/pages/create_note.dart';
import 'package:foodfirebase221210/pages/sign_in.dart';
import 'package:foodfirebase221210/pages/view_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference dbCollection = FirebaseFirestore.instance.collection('Notes');

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note app"),
        actions: [
          IconButton(
            onPressed: () {
              AuthService().logout().then(
                (value) {
                  if (value == 'Sign_out') {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const SignInPage()),
                      (route) => false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Error occured"),
                      ),
                    );
                  }
                },
              );
              ;
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CreateNotePage(),
              ),
            );
          },
          label: Row(
            children: [Icon(Icons.add), Text("Add note")],
          )),
      body: StreamBuilder(
        stream: dbCollection.doc(user!.uid).collection('MyNotes').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No note added yet !'),
              );
            } else {
              return ListView(
                children: [
                  ...snapshot.data!.docs.map((data) {
                    String title = data.get('title');
                    final time = data.get('time');
                    String body = data.get('body');
                    String id = data.id;

                    return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ViewNotePage(
                                title: title,
                                body: body,
                                id: id,
                              ),
                            ),
                          );
                        },
                        title: Text(title),
                        subtitle: Text("$time"),
                        trailing: IconButton(
                          onPressed: () {
                            DbHelper().delete(id: id).then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                            });
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                        ));
                  }),
                  const SizedBox(
                    height: 80,
                  )
                ],
              );
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching data'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
