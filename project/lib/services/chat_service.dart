import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/chat_message.dart';

/// Provides simple chat capabilities backed by Firestore.
class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  /// Uploads an attachment [file] and returns its download URL.
  Future<String> uploadAttachment(File file) async {
    final name = file.uri.pathSegments.last;
    final ref = _storage
        .ref()
        .child('attachments/${DateTime.now().millisecondsSinceEpoch}_$name');
    await ref.putFile(file);
    return ref.getDownloadURL();
  }

  /// Marks the message with [messageId] as read by [userId].
  Future<void> markAsRead(String messageId, String userId) async {
    final doc = _firestore.collection('messages').doc(messageId);
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(doc);
      final data = snapshot.data();
      final readBy = List<String>.from(data?['readBy'] ?? []);
      if (!readBy.contains(userId)) {
        readBy.add(userId);
        transaction.update(doc, {'readBy': readBy});
      }
    });
  }

  /// Updates the typing status for the user with [userId].
  Future<void> setTyping(String userId, bool isTyping) async {
    await _firestore
        .collection('typing')
        .doc(userId)
        .set({'isTyping': isTyping});
  }

  /// Streams the set of user IDs currently typing.
  Stream<Set<String>> typingUsersStream() {
    return _firestore.collection('typing').snapshots().map((snapshot) => {
          for (final doc in snapshot.docs)
            if (doc.data()['isTyping'] == true) doc.id,
        });
  }
}
