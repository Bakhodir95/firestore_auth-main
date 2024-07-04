import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_auth/controllers/chat_controller.dart';
import 'package:firestore_auth/models/message.dart';
import 'package:firestore_auth/widgets/sorted_id.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  final String email;
  const ChatsScreen({super.key, required this.email});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final typingController = TextEditingController();
  final ChatController _chatViewModel = ChatController();
  late final String _chatRoomId;
  final String _currentUserEmail = FirebaseAuth.instance.currentUser!.email!;

  @override
  void dispose() {
    typingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _chatRoomId = SortedFunction.generateChatRoomId(
        user1Email: widget.email, user2Email: _currentUserEmail);
  }

  void _sendMessage() {
    if (typingController.text.isNotEmpty) {
      _chatViewModel.sendMessage(
        text: typingController.text,
        senderId: _currentUserEmail,
        timeStamp: FieldValue.serverTimestamp(),
        chatRoomId: _chatRoomId,
      );
      typingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.email),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: _chatViewModel.getMessages(_chatRoomId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                var messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    Message message =
                        Message.fromQuerySnapshot(messages[index]);

                    return Row(
                      mainAxisAlignment: _currentUserEmail == message.senderId
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Text(message.message),
                      ],
                    );
                  },
                );
              },
            )),
            TextField(
              controller: typingController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: GestureDetector(
                  onTap: _sendMessage,
                  child: const Icon(Icons.send),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
