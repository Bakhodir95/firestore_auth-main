import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirerbaseService {
  final _userCollection = FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getUsers() async* {
    yield* _userCollection.snapshots();
  }

  void addUser({
    required String name,
    required String email,
    required String uid,
  }) {
    Map<String, dynamic> data = {
      'user-name': name,
      'user-email': email,
      'user-uid': uid,
    };
    _userCollection.add(data);
  }
}
