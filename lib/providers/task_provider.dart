import 'package:flutter/material.dart';

import '../models/task.dart';
import '../services/database_service.dart';

/// Provider managing tasks assigned to leaders.
class TaskProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();

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
    notifyListeners();
  }

  Future<void> toggleTask(String id) async {
    final task = _db.tasks.firstWhere((t) => t.id == id);
    task.isCompleted = !task.isCompleted;
    await _db.updateTask(task);
    notifyListeners();
  }
}
