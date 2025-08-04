import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../services/chat_service.dart';

/// Exposes chat messages and sending capabilities to the widget tree.
class ChatProvider extends ChangeNotifier {
  final ChatService _service = ChatService();

  Stream<List<ChatMessage>> get messages => _service.messagesStream();

  /// Sends a new message from the given [authorId].
  Future<void> send(String authorId, String text) async {
    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorId: authorId,
      text: text,
      timestamp: DateTime.now(),
    );
    await _service.sendMessage(message);
  }
}
