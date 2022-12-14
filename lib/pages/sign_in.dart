import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:foodfirebase221210/auth/auth_service.dart';
import 'package:foodfirebase221210/pages/home_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign in to continue"),
            Text(
              "Note Firebase",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () {
                AuthService().signInWithGoogle().then(
                  (value) {
                    if (value == 'Success') {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
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
              },
            ),
            SizedBox(height: 10),
            SignInButton(
              Buttons.AppleDark,
              text: "Sign up with Apple",
              onPressed: () {},
            ),
            SizedBox(height: 20),
            Text(
              "By signing in you are agreeing to our",
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
            Text(
              "Terms and Privacy Policy",
              style: TextStyle(
                color: Colors.grey[800],
              ),
            )
          ],
        ),
      ),
    );
  }
}
