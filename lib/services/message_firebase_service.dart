import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesFirebaseService {
  final _messagesCollection = FirebaseFirestore.instance.collection("messages");

  Stream<QuerySnapshot> getMessages() async* {
    yield* _messagesCollection.snapshots();
  }
}
