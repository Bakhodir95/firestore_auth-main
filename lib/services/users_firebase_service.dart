import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_auth/models/quiz.dart';
import 'package:firestore_auth/models/user.dart';

class UserFirerbaseService {
  final _userCollection = FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getUsers() async* {
    yield* _userCollection.snapshots();
  }

  void addUsers(Users user) {
    _userCollection.add({
      "message": user.message,
      "name": user.name,
    });
  }

  // void edidQuestion(Quiz quiz) {
  //   _questionCollection.doc(quiz.id).update({
  //     "question": quiz.question,
  //     "answer": quiz.answer,
  //     "variant": quiz.variant
  //   });
  // }

  // void deleteQuestion(Quiz quiz) {
  //   _questionCollection.doc(quiz.id).delete();
  // }
}
