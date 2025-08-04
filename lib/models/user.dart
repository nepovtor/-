/// Roles that a [User] can have inside the application.
enum UserRole { admin, leader, assistant }

/// Represents a leader or staff member who can use the application.
class User {
  /// Unique identifier for the user.
  final String id;

  /// Display name of the user.
  final String name;

  /// Set of roles assigned to the user.
  final Set<UserRole> roles;

  const User({
    required this.id,
    required this.name,
    this.roles = const {},
  });

  /// Convenience getter to check if the user is a leader.
  bool get isLeader => roles.contains(UserRole.leader);

  /// Creates a [User] instance from JSON.
  factory User.fromJson(Map<String, dynamic> json) {
    final roleNames = json['roles'] as List<dynamic>? ?? <dynamic>[];
    final roles = roleNames
        .map((e) => UserRole.values.firstWhere(
            (r) => r.name == e,
            orElse: () => UserRole.assistant))
        .toSet();
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      roles: roles,
    );
  }

  /// Converts this [User] into JSON.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'roles': roles.map((e) => e.name).toList(),
      };
}

