class User {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final bool verified;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.verified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      verified: json['verified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'verified': verified,
    };
  }

  User copyWith(Map<String, dynamic> model) {
    return User(
      id: model['id'] ?? id,
      name: model['name'] ?? name,
      email: model['email'] ?? email,
      avatar: model['avatar'] ?? avatar,
      verified: model['verified'] ?? verified,
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, avatar: $avatar, verified: $verified}';
  }
}
