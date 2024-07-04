import 'package:firestore_auth/controllers/users_controller.dart';
import 'package:firestore_auth/models/user.dart';
import 'package:firestore_auth/widgets/bottomnavigation_widget.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _usersController = UserController();
  final _bottomBar = BottomnavigationWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Conttact"),
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
                            ListTile(
                              title: Text(user.name),
                              subtitle: Text(user.message),
                              trailing: const CircleAvatar(
                                radius: 25,
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
