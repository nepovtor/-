import 'user.dart';

/// Represents an invitation sent to a new participant.
class Invitation {
  /// Unique identifier of the invitation document.
  final String id;

  /// Email address the invitation was sent to.
  final String email;

  /// Token that must be provided to accept the invitation.
  final String token;

  /// Roles the user will receive upon accepting the invitation.
  final Set<UserRole> roles;

  /// Creation timestamp of the invitation.
  final DateTime createdAt;

  const Invitation({
    required this.id,
    required this.email,
    required this.token,
    this.roles = const {},
    required this.createdAt,
  });

  /// Creates an [Invitation] from JSON.
  factory Invitation.fromJson(Map<String, dynamic> json) {
    final roleNames = json['roles'] as List<dynamic>? ?? <dynamic>[];
    final roles = roleNames
        .map((e) => UserRole.values.firstWhere(
              (r) => r.name == e,
              orElse: () => UserRole.assistant,
            ))
        .toSet();
    return Invitation(
      id: json['id'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      roles: roles,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// Converts this invitation into JSON.
  Map<String, dynamic> toJson() => {
        'email': email,
        'token': token,
        'roles': roles.map((e) => e.name).toList(),
        'createdAt': createdAt.toIso8601String(),
      };
}

