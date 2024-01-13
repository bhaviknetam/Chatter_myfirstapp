import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/auth_gate.dart';
import 'package:my_app/autn_service.dart';
import 'package:provider/provider.dart';
import 'package:rename/rename.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB_9djLXca2G7VLGet_jlombcaonQxiAaE",
      appId: "1:203385836425:android:2332a46e94fbfa579c4758",
      messagingSenderId: "203385836425",
      projectId: "chatapp-33626",
    ),
  );
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
