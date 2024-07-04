import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderId;
  final Timestamp datetime;
  final String message;

  Message({
    required this.id,
    required this.senderId,
    required this.datetime,
    required this.message,
  });
  factory Message.fromQuerySnapshot(QueryDocumentSnapshot query) {
    return Message(
      id: query.id,
      senderId: query['sender-id'],
      message: query['text'],
      datetime: query['time-stamp'] ?? Timestamp.now(),
    );
  }
}
