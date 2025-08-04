import 'package:flutter/material.dart';

import '../models/task.dart';
import '../services/database_service.dart';

/// Provider managing tasks assigned to leaders.
class TaskProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();

  List<Task> get tasks => _db.tasks;

  void addTask(Task task) {
    _db.addTask(task);
    notifyListeners();
  }

  void toggleTask(String id) {
    final task = _db.tasks.firstWhere((t) => t.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }
}

