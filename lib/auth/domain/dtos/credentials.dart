class Credentials {
  String email;
  String password;
  String? confirmPassword;

  Credentials({
    required this.email,
    required this.password,
    this.confirmPassword,
  });

  setPassword(String? password) => this.password = password ?? '';
  setEmail(String? email) => this.email = email ?? '';
  setConfirmPassword(String? confirmPassword) =>
      this.confirmPassword = confirmPassword ?? '';

  factory Credentials.empty() => Credentials(
        email: '',
        password: '',
        confirmPassword: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
