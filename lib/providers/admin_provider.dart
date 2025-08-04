import 'package:flutter/material.dart';

import '../models/invitation.dart';
import '../models/user.dart';
import '../services/admin_service.dart';

/// Provider exposing administrative actions to the widget tree.
class AdminProvider extends ChangeNotifier {
  final AdminService _service = AdminService();

  /// Stream of pending invitations.
  Stream<List<Invitation>> get invitations => _service.invitationsStream();

  /// Stream of all registered users.
  Stream<List<User>> get users => _service.usersStream();

  /// Creates a new invitation for [email].
  Future<Invitation> invite(String email, {Set<UserRole> roles = const {}}) {
    return _service.inviteUser(email, roles: roles);
  }

  /// Assigns [role] to [userId].
  Future<void> assignRole(String userId, UserRole role) {
    return _service.assignRole(userId, role);
  }

  /// Removes [role] from [userId].
  Future<void> removeRole(String userId, UserRole role) {
    return _service.removeRole(userId, role);
  }

  /// Updates roles of [userId] to exactly match [roles].
  Future<void> updateUserRoles(String userId, Set<UserRole> roles) {
    return _service.updateUserRoles(userId, roles);
  }

  /// Accepts an invitation and creates the user with [name].
  Future<void> acceptInvitation(String invitationId, String name) {
    return _service.acceptInvitation(invitationId, name);
  }

  /// Declines the invitation with [invitationId].
  Future<void> declineInvitation(String invitationId) {
    return _service.declineInvitation(invitationId);
  }

  /// Deletes the user with [userId].
  Future<void> deleteUser(String userId) {
    return _service.deleteUser(userId);
  }
}

