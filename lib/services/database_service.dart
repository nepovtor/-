import '../models/event.dart';
import '../models/task.dart';

/// In-memory database used for the prototype application.
class DatabaseService {
  final List<Event> _events = [];
  final List<Task> _tasks = [];

  List<Event> get events => List.unmodifiable(_events);
  List<Task> get tasks => List.unmodifiable(_tasks);

  void addEvent(Event event) => _events.add(event);

  void addTask(Task task) => _tasks.add(task);
}

