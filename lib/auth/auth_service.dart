import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodfirebase221210/pages/home_page.dart';
import 'package:foodfirebase221210/pages/sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    return 'Success';
  }

  Future<String> logout() async {
    auth.signOut();
    GoogleSignIn().signOut();

    return "Sign_out";
  }
}
