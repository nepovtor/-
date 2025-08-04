import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/event.dart';
import '../models/task.dart';

/// Handles syncing data with a remote Firestore backend.
class SyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> syncTasks(List<Task> tasks) async {
    final batch = _firestore.batch();
    final collection = _firestore.collection('tasks');
    for (final task in tasks) {
      batch.set(collection.doc(task.id), task.toJson());
    }
    await batch.commit();
  }

  Future<void> syncEvents(List<Event> events) async {
    final batch = _firestore.batch();
    final collection = _firestore.collection('events');
    for (final event in events) {
      batch.set(collection.doc(event.id), event.toJson());
    }
    await batch.commit();
  }
}

