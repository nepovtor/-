import 'package:flutter/material.dart';

import '../models/invitation.dart';
import '../models/user.dart';
import '../services/admin_service.dart';

/// Provider exposing administrative actions to the widget tree.
class AdminProvider extends ChangeNotifier {
  final AdminService _service = AdminService();

  /// Stream of pending invitations.
  Stream<List<Invitation>> get invitations => _service.invitationsStream();

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
}

