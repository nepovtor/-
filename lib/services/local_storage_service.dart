import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/event.dart';
import '../models/task.dart';

/// Handles persistence using [SharedPreferences].
class LocalStorageService {
  static const _eventsKey = 'events';
  static const _tasksKey = 'tasks';

  Future<List<Event>> loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_eventsKey) ?? [];
    return data
        .map((e) => Event.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveEvents(List<Event> events) async {
    final prefs = await SharedPreferences.getInstance();
    final data = events.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_eventsKey, data);
  }

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_tasksKey) ?? [];
    return data
        .map((e) => Task.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final data = tasks.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_tasksKey, data);
  }
}
