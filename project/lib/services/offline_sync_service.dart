import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/event.dart';
import '../models/task.dart';
import 'local_storage_service.dart';
import 'sync_service.dart';

/// Handles offline persistence and automatic synchronization when
/// connectivity is restored.
class OfflineSyncService {
  final Connectivity _connectivity = Connectivity();
  final LocalStorageService _local = LocalStorageService();
  final SyncService _remote = SyncService();

  StreamSubscription<ConnectivityResult>? _subscription;

  /// Starts listening to connectivity changes to perform auto-sync.
  void start() {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        _syncPending();
      }
    });
  }

  /// Cancels the connectivity subscription.
  Future<void> dispose() async {
    await _subscription?.cancel();
  }

  /// Saves a [task] locally when offline.
  Future<void> saveTaskOffline(Task task) async {
    final tasks = await _local.loadTasks();
    await _local.saveTasks([...tasks, task]);
  }

  /// Saves an [event] locally when offline.
  Future<void> saveEventOffline(Event event) async {
    final events = await _local.loadEvents();
    await _local.saveEvents([...events, event]);
  }

  /// Attempts to sync any locally saved tasks and events.
  Future<void> _syncPending() async {
    final tasks = await _local.loadTasks();
    if (tasks.isNotEmpty) {
      await _remote.syncTasks(tasks);
      await _local.saveTasks([]);
    }
    final events = await _local.loadEvents();
    if (events.isNotEmpty) {
      await _remote.syncEvents(events);
      await _local.saveEvents([]);
    }
  }
}
