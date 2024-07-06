import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesFirebaseService {
  final _messagesCollection = FirebaseFirestore.instance.collection("messages");
  final String _collectedName = 'messages';

  Stream<QuerySnapshot> getMessages(String chatRoomId) async* {
    yield* _messagesCollection
        .doc(chatRoomId)
        .collection(_collectedName)
        .orderBy('time-stamp', descending: true)
        .snapshots();
  }

  void sendMessage({
    required Map<String, dynamic> data,
    required String chatRoomId,
  }) {
    _messagesCollection.doc(chatRoomId).collection(_collectedName).add(data);
  }

  Future<void> editMessages(
      String id, String newMessage, String chatroomId) async {
    try {
      await _messagesCollection
          .doc(chatroomId)
          .collection('messages')
          .doc(id)
          .update({'message': newMessage});
    } catch (e) {
      print('Error editing message: $e');
    }
  }

  Future<void> deleteMessages(String id, String chatroomId) async {
    try {
      await _messagesCollection
          .doc(chatroomId)
          .collection("message")
          .doc(id)
          .delete();
    } catch (e) {
      print('Error deleting message: $e');
    }
  }
}
