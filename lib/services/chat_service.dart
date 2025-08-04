import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_message.dart';

/// Provides simple chat capabilities backed by Firestore.
class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Streams chat messages ordered by their timestamp.
  Stream<List<ChatMessage>> messagesStream() {
    return _firestore
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessage.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList());
  }

  /// Sends a new [message] to the backend.
  Future<void> sendMessage(ChatMessage message) async {
    await _firestore
        .collection('messages')
        .doc(message.id)
        .set(message.toJson());
  }
}
