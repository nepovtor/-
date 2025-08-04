import '../models/event.dart';
import '../models/task.dart';
import 'local_storage_service.dart';

/// Repository that persists data using [LocalStorageService].
class DatabaseService {
  final LocalStorageService _storage = LocalStorageService();
  final List<Event> _events = [];
  final List<Task> _tasks = [];

  List<Event> get events => List.unmodifiable(_events);
  List<Task> get tasks => List.unmodifiable(_tasks);

  /// Loads events from local storage.
  Future<void> loadEvents() async {
    _events
      ..clear()
      ..addAll(await _storage.loadEvents());
  }

  /// Loads tasks from local storage.
  Future<void> loadTasks() async {
    _tasks
      ..clear()
      ..addAll(await _storage.loadTasks());
  }

  /// Adds a new event and persists the list.
  Future<void> addEvent(Event event) async {
    _events.add(event);
    await _storage.saveEvents(_events);
  }

  /// Adds a new task and persists the list.
  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await _storage.saveTasks(_tasks);
  }

  /// Updates an existing task and persists the list.
  Future<void> updateTask(Task task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      await _storage.saveTasks(_tasks);
    }
  }
}
