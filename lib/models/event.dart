import 'task.dart';

/// Represents an event happening at the camp.
class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final List<Task> tasks;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.tasks = const [],
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        date: DateTime.parse(json['date'] as String),
        tasks: (json['tasks'] as List<dynamic>? ?? [])
            .map((e) => Task.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'date': date.toIso8601String(),
        'tasks': tasks.map((e) => e.toJson()).toList(),
      };
}

