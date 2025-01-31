import 'package:harmonia/domain/models/user.dart';
import 'package:harmonia/shareds/client_http.dart';

class AuthService {
  static User? user;
  final ClientHttp client;

  static const String baseHttp = 'https://app.solutil.com.br/api';
  static const String email = 'slproger@gmail.com';
  static const String password = '12345678';

  AuthService(this.client) {
    login(email, password);
  }

  User? get currentUser => user;

  Future<void> login(String email, String password) async {
    final result = await client.post(
      '$baseHttp/users/auth-with-password',
      body: {'identity': email, 'password': password},
    );
    user = User.fromJson(result.data['record']);
    await client.setToken(
      user,
      result.data['token'],
    );
  }
}
