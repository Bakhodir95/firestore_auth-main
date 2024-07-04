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
}
