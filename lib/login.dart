import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Forgot_pw.dart';
import 'package:my_app/MyButton.dart';
import 'package:provider/provider.dart';

import 'autn_service.dart';

class MyLogin extends StatefulWidget {
  final void Function()? onTap;
  const MyLogin({super.key, required this.onTap});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void signin() async {
    final authservice = Provider.of<AuthService>(context, listen: false);
    try {
      await authservice.signin(_emailController.text, _passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Email or Password is wrong!',
        ),
      ));
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
          body: Stack(
            children: [
              Center(
                child: Container(
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Text(
                        'Welcome Back😎',
                        style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        'Fill in your login details✍🏼',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Icon(
                        Icons.perm_phone_msg_outlined,
                        size: 100,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
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
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const ForgotPasswordPage();
                                }));
                              },
                              child: Text(
                                'Forgot Password?🤞',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyButton(onTap: signin, text: 'Sign In'),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Not a member?',
                            style: GoogleFonts.montserrat(),
                          ),
                          const SizedBox(width: 3),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              'Register here📄',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
