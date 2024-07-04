import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String id;
  String uid;
  String name;
  String email;

  Users(
      {required this.id,
      required this.uid,
      required this.name,
      required this.email});

  factory Users.fromMap(QueryDocumentSnapshot query) {
    return Users(
      id: query.id,
      name: query['user_name'],
      uid: query['user_uid'],
      email: query['user-email'],
    );
  }
}
