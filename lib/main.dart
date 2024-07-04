import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_auth/controllers/users_controller.dart';
import 'package:firestore_auth/firebase_options.dart';
import 'package:firestore_auth/screens/contacts_screen.dart';
import 'package:firestore_auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return UserController();
    }, builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot snapshot) {
              print(snapshot);
              if (snapshot.data == null || !snapshot.hasData) {
                return const LoginScreen();
              }
              return const ContactsScreen();
            }),
      );
    });
  }
}
