import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirerbaseService {
  final _userCollection = FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getUsers() async* {
    yield* _userCollection.snapshots();
  }

  addUser({
    required String name,
    required String email,
    required String uid,
  }) async {
    Map<String, dynamic> data = {
      'user-name': name,
      'user-email': email,
      'user-uid': uid,
    };
    await _userCollection.add(data);
  }
}
