import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_auth/screens/login_screen.dart';
import 'package:firestore_auth/widgets/manage_cars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePickScreen extends StatefulWidget {
  const ImagePickScreen({super.key});

  @override
  State<ImagePickScreen> createState() => _ImagePickScreenState();
}

class _ImagePickScreenState extends State<ImagePickScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text("HomeScreen"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                setState(() {});
                Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      // body: ManageCars(),
    );
  }
}
