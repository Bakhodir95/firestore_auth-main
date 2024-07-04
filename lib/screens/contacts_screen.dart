import 'package:firestore_auth/controllers/users_controller.dart';
import 'package:firestore_auth/models/user.dart';
import 'package:firestore_auth/screens/chats_screen.dart';
import 'package:firestore_auth/widgets/bottomnavigation_widget.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _usersController = UserController();
  final _bottomBar = const BottomnavigationWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Contact"),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        ),
        body: StreamBuilder(
            stream: _usersController.list,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data == null) {
                return const Center(
                  child: Text(" No Users here  yet!"),
                );
              }
              final users = snapshot.data!.docs;
              return users.isEmpty
                  ? const Center(
                      child: Text(" No questions yet!"),
                    )
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        final user = Users.fromMap(users[index]);
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue,
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) =>
                                            ChatsScreen(email: user.email),
                                      ),
                                    );
                                  },
                                  title: Text(user.name),
                                  subtitle: Text(user.id),
                                  trailing: CircleAvatar(
                                    radius: 25,
                                    // Placeholder avatar setup
                                    child: Text(user.name[0]),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
            }),
        bottomNavigationBar: _bottomBar);
  }
}
