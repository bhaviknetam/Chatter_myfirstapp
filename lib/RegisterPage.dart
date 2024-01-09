// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/MyButton.dart';
import 'package:provider/provider.dart';

import 'autn_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  void signup() async {
    final authservice = Provider.of<AuthService>(context, listen: false);
    try {
      if (passwordConfirmed()) {
        await authservice.signup(
            _emailController.text, _passwordController.text);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Passwords do not match!',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
        ),
      ));
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Column(
                  children: [
                    Text(
                      'HELLO THERE',
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      'Register below with your details',
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Icon(
                      Icons.messenger_outline_sharp,
                      size: 100,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4,
                  right: 35,
                  left: 35),
              child: SingleChildScrollView(
                child: Column(children: [
                  TextField(
                    controller: _emailController,
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
                    height: 20,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Colors.white12,
                        filled: true,
                        hintText: 'Password',
                        hintStyle: GoogleFonts.montserrat(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _confirmpasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Colors.white12,
                        filled: true,
                        hintText: 'Confirm Password',
                        hintStyle: GoogleFonts.montserrat(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyButton(onTap: signup, text: 'Sign Up'),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        'Already a member?',
                        style: GoogleFonts.montserrat(),
                      ),
                      const SizedBox(width: 3),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Login',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
