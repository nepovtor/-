import 'package:flutter/material.dart';

import '../models/event.dart';
import '../services/database_service.dart';
import '../services/sync_service.dart';

/// Provider that exposes events to the application.
class EventProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  final SyncService _sync = SyncService();

  EventProvider() {
    _init();
  }

  List<Event> get events => _db.events;

  Future<void> _init() async {
    await _db.loadEvents();
    notifyListeners();
  }

  Future<void> addEvent(Event event) async {
    await _db.addEvent(event);
    await _sync.syncEvents(_db.events);
    notifyListeners();
  }
}
