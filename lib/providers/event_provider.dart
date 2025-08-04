import 'package:flutter/material.dart';

import '../models/event.dart';
import '../services/database_service.dart';

/// Provider that exposes events to the application.
class EventProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();

  List<Event> get events => _db.events;

  void addEvent(Event event) {
    _db.addEvent(event);
    notifyListeners();
  }
}

