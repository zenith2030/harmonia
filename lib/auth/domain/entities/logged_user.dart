import 'user.dart';

class LoggedUser extends User {
  final String token;
  final String refreshToken;

  LoggedUser({
    required super.id,
    required super.name,
    required super.email,
    required super.avatar,
    required super.verified,
    required this.token,
    required this.refreshToken,
  });

  factory LoggedUser.fromJson(Map<String, dynamic> json) {
    return LoggedUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      verified: json['verified'],
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'verified': verified,
      'token': token,
      'refreshToken': refreshToken,
    };
  }

  LoggedUser copyWith(Map<String, dynamic> model) {
    return LoggedUser(
      id: model['id'] ?? id,
      name: model['name'] ?? name,
      email: model['email'] ?? email,
      avatar: model['avatar'] ?? avatar,
      verified: model['verified'] ?? verified,
      token: model['token'] ?? token,
      refreshToken: model['refreshToken'] ?? refreshToken,
    );
  }

  @override
  String toString() {
    return 'LoggedUser{id: $id, name: $name, email: $email, avatar: $avatar, verified: $verified, token: $token, refreshToken: $refreshToken}';
  }
}
