/// Represents a single chat message between leaders.
class ChatMessage {
  final String id;
  final String authorId;
  final String text;
  final DateTime timestamp;
  final List<String> attachments;
  final List<String> readBy;

  ChatMessage({
    required this.id,
    required this.authorId,
    required this.text,
    required this.timestamp,
    this.attachments = const [],
    this.readBy = const [],
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json['id'] as String,
        authorId: json['authorId'] as String,
        text: json['text'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
        attachments:
            (json['attachments'] as List<dynamic>? ?? []).cast<String>(),
        readBy: (json['readBy'] as List<dynamic>? ?? []).cast<String>(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'authorId': authorId,
        'text': text,
        'timestamp': timestamp.toIso8601String(),
        'attachments': attachments,
        'readBy': readBy,
      };
}
