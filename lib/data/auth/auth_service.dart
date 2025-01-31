import 'package:harmonia/domain/models/user.dart';
import 'package:harmonia/shareds/client_http.dart';

class AuthService {
  static User? _user;
  final ClientHttp client;

  static const String baseHttp = 'https://solutil.com.br/api/collections/users';
  static const String email = 'slproger@gmail.com';
  static const String password = '12345678';

  AuthService(this.client) {
    login(email, password);
  }

  User? get currentUser => _user;

  Future<void> login(String email, String password) async {
    final result = await client.post(
      '$baseHttp/auth-with-password',
      body: {'identity': email, 'password': password},
    );
    _user = User.fromJson(result.data['record']);
    await client.setToken(
      _user,
      result.data['token'],
    );
  }

  Future<void> logout() async {
    await client.clearToken();
    _user = null;
  }
}
