/// Represents a task assigned to a leader.
class Task {
  final String id;
  final String description;
  bool isCompleted;

  Task({
    required this.id,
    required this.description,
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as String,
        description: json['description'] as String,
        isCompleted: json['isCompleted'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'isCompleted': isCompleted,
      };
}

