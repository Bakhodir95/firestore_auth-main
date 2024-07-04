import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_auth/services/users_firebase_service.dart';
import 'package:flutter/material.dart';

class UserController with ChangeNotifier {
  final _usersFirebaseService = UserFirerbaseService();

  Stream<QuerySnapshot> get list async* {
    yield* _usersFirebaseService.getUsers();
  }

  void addUser({
    required String name,
    required String email,
    required uid,
  }) {
    _usersFirebaseService.addUser(
      name: name,
      email: email,
      uid: uid,
    );
  }
}
