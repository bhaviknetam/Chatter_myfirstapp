import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signin(String email, String password) async {
    try {
      UserCredential usercred = await firebaseauth.signInWithEmailAndPassword(
          email: email, password: password);
      _firestore.collection('users').doc(usercred.user!.uid).set({
        'uid': usercred.user!.uid,
        'email': email,
      }, SetOptions(merge: true));
      return usercred;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signup(String email, String password) async {
    try {
      UserCredential usercred = await firebaseauth
          .createUserWithEmailAndPassword(email: email, password: password);
      _firestore.collection('users').doc(usercred.user!.uid).set({
        'uid': usercred.user!.uid,
        'email': email,
      });
      return usercred;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
