/// Represents a task assigned to a leader.
class Task {
  final String id;
  final String description;
  bool isCompleted;
  final String category;
  final int priority;
  final String repeatInterval;

  Task({
    required this.id,
    required this.description,
    this.isCompleted = false,
    this.category = '',
    this.priority = 0,
    this.repeatInterval = 'none',
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as String,
        description: json['description'] as String,
        isCompleted: json['isCompleted'] as bool? ?? false,
        category: json['category'] as String? ?? '',
        priority: json['priority'] as int? ?? 0,
        repeatInterval: json['repeatInterval'] as String? ?? 'none',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'isCompleted': isCompleted,
        'category': category,
        'priority': priority,
        'repeatInterval': repeatInterval,
      };
}

