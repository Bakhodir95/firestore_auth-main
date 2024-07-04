import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_auth/models/quiz.dart';
import 'package:firestore_auth/services/quiz_firerbase_service.dart';
import 'package:flutter/foundation.dart';

class QuizController extends ChangeNotifier {
  final _questionFirebaseService = QuizFirerbaseService();

  Stream<QuerySnapshot> get list {
    return _questionFirebaseService.getQuestions();
  }

  void addQuestion(Quiz quiz) {
    _questionFirebaseService.addQuestion(quiz);
  }

  void editQuestion(Quiz quiz) {
    _questionFirebaseService.edidQuestion(quiz);
  }

  void deleteQuestion() {
    // _questionFirebaseService.deleteQuestion()
  }
}
