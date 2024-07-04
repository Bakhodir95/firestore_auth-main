import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_auth/services/message_firebase_service.dart';

class ChatController {
  final _chatFirebaseService = MessagesFirebaseService();

  Stream<QuerySnapshot> getMessages(String chatRoomId) async* {
    yield* _chatFirebaseService.getMessages(chatRoomId);
  }

  void sendMessage({
    required String text,
    required String senderId,
    required FieldValue timeStamp,
    required String chatRoomId,
  }) {
    _chatFirebaseService.sendMessage(
      data: {
        'text': text,
        'sender-id': senderId,
        'time-stamp': timeStamp,
      },
      chatRoomId: chatRoomId,
    );
  }
}
