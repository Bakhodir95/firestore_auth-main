import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String id;
  String name;
  String message;

  Users({required this.id, required this.name, required this.message});

  factory Users.fromMap(QueryDocumentSnapshot query) {
    return Users(
      id: query.id,
      name: query['name'],
      message: query['message'],
    );
  }
}
