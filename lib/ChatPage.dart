import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/ChatBubble.dart';
import 'package:my_app/chat.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  final String username;
  const ChatPage(
      {super.key,
      required this.receiverEmail,
      required this.receiverID,
      required this.username});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ChatService _chatservice = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatservice.sendMessage(
          widget.receiverID, messageController.text, widget.username);

      messageController.clear();
    }
  }

  final _numbertoMonthMap = {
    1: "Jan",
    2: "Feb",
    3: "Mar",
    4: "Apr",
    5: "May",
    6: "June",
    7: "July",
    8: "Aug",
    9: "Sep",
    10: "Oct",
    11: "Nov",
    12: "Dec"
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
        title: Text(widget.username,
            style: GoogleFonts.montserrat(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.none,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          buildMessageinput(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatservice.getMessages(
          widget.receiverID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(QueryDocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    Timestamp t = data['timestamp'] as Timestamp;
    DateTime date = t.toDate();
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment:
                (data['senderId'] == _firebaseAuth.currentUser!.uid)
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            mainAxisAlignment:
                (data['senderId'] == _firebaseAuth.currentUser!.uid)
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: [
              Text(
                (data['senderId'] == _firebaseAuth.currentUser!.uid)
                    ? "You"
                    : data['username'],
              ),
              const SizedBox(
                height: 5,
              ),
              ChatBubble(message: data['message']),
              Text('${_numbertoMonthMap[date.month]} ${date.day} ${date.year}',
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  )),
              Text('${date.hour}:${date.minute} ${date.timeZoneName}',
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ))
            ]),
      ),
    );
  }

  Widget buildMessageinput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                  fillColor: Colors.white12,
                  filled: true,
                  hintText: 'Type a message',
                  hintStyle: GoogleFonts.montserrat(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_forward,
                size: 40,
              ))
        ],
      ),
    );
  }
}
