import 'package:flutter/material.dart';
import 'package:my_app/RegisterPage.dart';
import 'package:my_app/login.dart';

class LoginORreg extends StatefulWidget {
  const LoginORreg({super.key});

  @override
  State<LoginORreg> createState() => _LoginORregState();
}

class _LoginORregState extends State<LoginORreg> {
  bool showLoginPage = true;

  void togglepages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return MyLogin(onTap: togglepages);
    } else {
      return RegisterPage(onTap: togglepages);
    }
  }
}
