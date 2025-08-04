import 'dart:async';

import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../services/chat_service.dart';
import '../services/notification_service.dart';

/// Exposes chat messages and sending capabilities to the widget tree.
class ChatProvider extends ChangeNotifier {
  final ChatService _service = ChatService();
  final NotificationService _notifications = NotificationService();

  StreamSubscription<List<ChatMessage>>? _subscription;
  String? _lastMessageId;

  Stream<List<ChatMessage>> get messages => _service.messagesStream();

  /// Starts listening for new messages to trigger local notifications.
  void startListening(String currentUserId) {
    _subscription?.cancel();
    _subscription = _service.messagesStream().listen((msgs) {
      if (msgs.isEmpty) return;
      final latest = msgs.last;
      if (latest.id != _lastMessageId && latest.authorId != currentUserId) {
        _notifications.showNotification('New message', latest.text);
        _lastMessageId = latest.id;
      }
    });
  }

  /// Sends a new message from the given [authorId] with optional [attachments].
  Future<void> send(
    String authorId,
    String text, {
    List<String> attachments = const [],
  }) async {
    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorId: authorId,
      text: text,
      timestamp: DateTime.now(),
      attachments: attachments,
    );
    await _service.sendMessage(message);
  }

  /// Marks message with [messageId] as read by [userId].
  Future<void> markAsRead(String messageId, String userId) async {
    await _service.markAsRead(messageId, userId);
  }

  /// Updates typing status for the current user.
  Future<void> setTyping(String userId, bool isTyping) async {
    await _service.setTyping(userId, isTyping);
  }

  /// Stream of user IDs currently typing.
  Stream<Set<String>> typingUsers() => _service.typingUsersStream();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
