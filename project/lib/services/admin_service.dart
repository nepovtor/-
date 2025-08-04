import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/invitation.dart';
import '../models/user.dart';

/// Provides administrative user management features.
class AdminService {
  final FirebaseFirestore _firestore;
  final Random _random;

  AdminService({FirebaseFirestore? firestore, Random? random})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _random = random ?? Random();

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

  /// Streams all registered users.
  Stream<List<User>> usersStream() {
    return _firestore.collection('users').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => User.fromJson({
                    ...doc.data(),
                    'id': doc.id,
                  }))
              .toList(),
        );
  }

  /// Accepts an invitation by creating a user with [name] and the
  /// invitation's roles. The invitation document is removed afterwards.
  Future<void> acceptInvitation(String invitationId, String name) async {
    final ref = _firestore.collection('invitations').doc(invitationId);
    final snapshot = await ref.get();
    final data = snapshot.data();
    if (data == null) return;
    final roles = (data['roles'] as List<dynamic>? ?? [])
        .map((e) => UserRole.values.firstWhere(
              (r) => r.name == e,
              orElse: () => UserRole.assistant,
            ))
        .toSet();
    final userRef = _firestore.collection('users').doc();
    final user = User(id: userRef.id, name: name, roles: roles);
    await userRef.set(user.toJson());
    await ref.delete();
  }

  /// Declines an invitation by simply deleting it.
  Future<void> declineInvitation(String invitationId) async {
    await _firestore.collection('invitations').doc(invitationId).delete();
  }

  /// Updates the [roles] of the user with [userId].
  Future<void> updateUserRoles(String userId, Set<UserRole> roles) async {
    await _firestore.collection('users').doc(userId).update({
      'roles': roles.map((e) => e.name).toList(),
    });
  }

  /// Deletes the user with [userId].
  Future<void> deleteUser(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
  }
}

