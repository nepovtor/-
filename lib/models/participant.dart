/// Represents a participant at the camp.
class Participant {
  final String id;
  final String name;
  final int age;
  final String cabin;

  const Participant({
    required this.id,
    required this.name,
    required this.age,
    required this.cabin,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json['id'] as String,
        name: json['name'] as String,
        age: json['age'] as int,
        cabin: json['cabin'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'cabin': cabin,
      };
}

