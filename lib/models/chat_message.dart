/// Represents a single chat message between leaders.
class ChatMessage {
  final String id;
  final String authorId;
  final String text;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.authorId,
    required this.text,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json['id'] as String,
        authorId: json['authorId'] as String,
        text: json['text'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'authorId': authorId,
        'text': text,
        'timestamp': timestamp.toIso8601String(),
      };
}
