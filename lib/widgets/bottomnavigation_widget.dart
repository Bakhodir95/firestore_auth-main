import 'package:firestore_auth/screens/contacts_screen.dart';
import 'package:firestore_auth/screens/chats_screen.dart';
import 'package:flutter/material.dart';

class BottomnavigationWidget extends StatefulWidget {
  const BottomnavigationWidget({super.key});

  @override
  State<BottomnavigationWidget> createState() => _BottomnavigationWidgetState();
}

class _BottomnavigationWidgetState extends State<BottomnavigationWidget> {
  int _selectedIndex = 0;

  static final List<Widget> _screenOptions = [
    const ContactsScreen(),
    const ChatsScreen(
      email: '',
    ),
    const Text("More"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Text("Contacts"),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Text("More"),
          label: '',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}
