import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final typingController = TextEditingController();

  @override
  void dispose() {
    typingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: typingController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Input Text ...",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Handle send button tap
                  },
                  icon: const Icon(
                    Icons.send,
                    size: 30,
                    color: Colors.green,
                    fill: BorderSide.strokeAlignOutside,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
