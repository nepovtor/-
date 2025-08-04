import 'package:flutter/material.dart';

import '../models/task.dart';
import '../services/database_service.dart';
import '../services/sync_service.dart';

/// Provider managing tasks assigned to leaders.
class TaskProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  final SyncService _sync = SyncService();

  TaskProvider() {
    _init();
  }

  List<Task> get tasks => _db.tasks;

  Future<void> _init() async {
    await _db.loadTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _db.addTask(task);
    await _sync.syncTasks(_db.tasks);
    notifyListeners();
  }

  Future<void> toggleTask(String id) async {
    final task = _db.tasks.firstWhere((t) => t.id == id);
    task.isCompleted = !task.isCompleted;
    await _db.updateTask(task);
    await _sync.syncTasks(_db.tasks);
    notifyListeners();
  }

  Future<void> reorderTasks(int oldIndex, int newIndex) async {
    await _db.reorderTasks(oldIndex, newIndex);
    await _sync.syncTasks(_db.tasks);
    notifyListeners();
  }
}
