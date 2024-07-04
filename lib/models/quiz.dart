import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String id;
  String question;
  List<dynamic> variant;
  int answer;

  Quiz(
      {required this.id,
      required this.question,
      required this.variant,
      required this.answer});

  factory Quiz.fromJson(QueryDocumentSnapshot query) {
    return Quiz(
      id: query.id,
      answer: query['answer'],
      question: query['question'],
      variant: query['variant'],
    );
  }
}
