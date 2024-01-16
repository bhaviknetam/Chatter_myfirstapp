// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/MyButton.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailcontroller.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Password reset link sent! Check your email'),
            );
          });
    } on FirebaseAuthException {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('User does not exist!'),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.indigo, Colors.deepPurple],
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
          right: 35,
          left: 35,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Reset Password🤔',
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        'Enter your email address and we will send you a password reset link',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                          fillColor: Colors.white12,
                          filled: true,
                          hintText: 'Email',
                          hintStyle: GoogleFonts.montserrat(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MyButton(onTap: passwordReset, text: 'Confirm'),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
