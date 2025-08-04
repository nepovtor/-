/// Represents a daily report written by a leader.
class Report {
  final String id;
  final String authorId;
  final String content;
  final DateTime createdAt;

  Report({
    required this.id,
    required this.authorId,
    required this.content,
    required this.createdAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json['id'] as String,
        authorId: json['authorId'] as String,
        content: json['content'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'authorId': authorId,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
      };
}

