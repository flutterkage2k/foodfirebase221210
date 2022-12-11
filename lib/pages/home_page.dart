import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodfirebase221210/auth/auth_service.dart';
import 'package:foodfirebase221210/pages/create_note.dart';
import 'package:foodfirebase221210/pages/sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
      body: Text("HomePage"),
    );
  }
}
