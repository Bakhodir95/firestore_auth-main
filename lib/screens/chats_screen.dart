import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_auth/controllers/chat_controller.dart';
import 'package:firestore_auth/models/message.dart';
import 'package:firestore_auth/services/message_firebase_service.dart';
import 'package:firestore_auth/widgets/sorted_id.dart';

class ChatsScreen extends StatefulWidget {
  final String email;

  const ChatsScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController typingController = TextEditingController();
  final ChatController _chatViewModel = ChatController();
  late String _chatRoomId;
  late String _currentUserEmail;
  final _messageFirebaseService = MessagesFirebaseService();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(child: Text("No messages"));
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
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _currentUserEmail == message.senderId
                                  ? Colors.grey
                                  : Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GestureDetector(
                              onDoubleTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text("Delete message"),
                                    content: Text(
                                        "Are you sure you want to delete this message?"),
                                    actions: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _messageFirebaseService
                                              .deleteMessages(
                                                  message.id, _chatRoomId);
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: const Text("Delete"),
                                      )
                                    ],
                                  ),
                                );
                              },
                              onTap: () {
                                _textController.text = message.message;
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text("Edit message"),
                                    content: TextField(
                                      controller: _textController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    actions: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _messageFirebaseService.editMessages(
                                              message.id,
                                              _textController.text,
                                              _chatRoomId);
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: const Text("Save"),
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: Text(
                                message.message,
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
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
