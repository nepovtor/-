/// Represents a leader or staff member who can use the application.
class User {
  /// Unique identifier for the user.
  final String id;

  /// Display name of the user.
  final String name;

  /// Flag indicating if the user is a camp leader.
  final bool isLeader;

  const User({
    required this.id,
    required this.name,
    this.isLeader = false,
  });

  /// Creates a [User] instance from JSON.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      isLeader: json['isLeader'] as bool? ?? false,
    );
  }

  /// Converts this [User] into JSON.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'isLeader': isLeader,
      };
}

