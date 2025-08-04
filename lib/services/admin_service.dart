import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/invitation.dart';
import '../models/user.dart';

/// Provides administrative user management features.
class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Random _random = Random();

  /// Generates a simple random token for invitations.
  String _generateToken() => _random.nextInt(1 << 32).toRadixString(16);

  /// Creates a new invitation for [email] with optional [roles].
  Future<Invitation> inviteUser(String email, {Set<UserRole> roles = const {}}) async {
    final token = _generateToken();
    final doc = _firestore.collection('invitations').doc();
    final invitation = Invitation(
      id: doc.id,
      email: email,
      token: token,
      roles: roles,
      createdAt: DateTime.now(),
    );
    await doc.set(invitation.toJson());
    // In a real application, an email would be sent to [email] containing
    // a link or the token. Here we simply persist the invitation.
    return invitation;
  }

  /// Assigns [role] to the user with [userId].
  Future<void> assignRole(String userId, UserRole role) async {
    final ref = _firestore.collection('users').doc(userId);
    await _firestore.runTransaction((tx) async {
      final snapshot = await tx.get(ref);
      final data = snapshot.data() ?? <String, dynamic>{};
      final roles = List<String>.from(data['roles'] ?? []);
      if (!roles.contains(role.name)) {
        roles.add(role.name);
        tx.set(ref, {...data, 'roles': roles});
      }
    });
  }

  /// Removes [role] from the user with [userId].
  Future<void> removeRole(String userId, UserRole role) async {
    final ref = _firestore.collection('users').doc(userId);
    await _firestore.runTransaction((tx) async {
      final snapshot = await tx.get(ref);
      final data = snapshot.data() ?? <String, dynamic>{};
      final roles = List<String>.from(data['roles'] ?? []);
      roles.remove(role.name);
      tx.set(ref, {...data, 'roles': roles});
    });
  }

  /// Streams all pending invitations.
  Stream<List<Invitation>> invitationsStream() {
    return _firestore
        .collection('invitations')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Invitation.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList());
  }
}

