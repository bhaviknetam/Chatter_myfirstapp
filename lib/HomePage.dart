import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/ChatPage.dart';
import 'package:my_app/autn_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signOut() {
    final authservice = Provider.of<AuthService>(context, listen: false);

    authservice.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Chats',
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ))),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout)),
        ],
      ),
      body: buildUserList(),
    );
  }

  Widget buildUserList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['username'].toString(),
            style: GoogleFonts.oldStandardTt(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: TextDecoration.none,
            )),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverEmail: data['email'],
                        receiverID: data['uid'],
                        username: data['username'],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
