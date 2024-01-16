import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
      String receiverId, String message, String username) async {
    final String currentId = _firebaseAuth.currentUser!.uid;
    final String currentEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentId,
        senderEmail: currentEmail,
        receiverId: receiverId,
        username: username,
        message: message,
        timestamp: timestamp);

    List<String> ids = [currentId, receiverId];
    ids.sort();
    String chatroomId = ids.join("_");

    await _firestore
        .collection('chat_room')
        .doc(chatroomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otheruserId) {
    List<String> ids = [userId, otheruserId];
    ids.sort();
    String chatroomId = ids.join("_");
    return _firestore
        .collection('chat_room')
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
