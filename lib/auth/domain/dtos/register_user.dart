class RegisterUser {
  String name;
  String email;
  String password;
  String passwordConfirm;

  RegisterUser({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirm,
  });

  factory RegisterUser.empty() => RegisterUser(
        name: '',
        email: '',
        password: '',
        passwordConfirm: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': passwordConfirm,
    };
  }
}
