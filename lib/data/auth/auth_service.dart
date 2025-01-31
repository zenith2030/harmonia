import 'dart:io';

import 'package:harmonia/domain/models/user.dart';
import 'package:harmonia/shareds/client_http.dart';
import 'package:harmonia/shareds/errors/http_error.dart';
import 'package:result_dart/result_dart.dart';

class AuthService {
  static User? _user;
  final ClientHttp client;

  static const String baseHttp = 'https://solutil.com.br/api/collections/users';
  static const String email = 'slproger@gmail.com';
  static const String password = '12345678';

  AuthService(this.client);

  User? get currentUser => _user;

  AsyncResult<User> login(String email, String password) async {
    final result = await client.post(
      '$baseHttp/auth-with-password',
      body: {'identity': email, 'password': password},
    );
    try {
      _user = User.fromJson(result.data['record']);
      await client.setToken(_user, result.data['token']);
      return Success(_user!);
    } catch (e, s) {
      return Failure(HttpResponseError(message: e.toString(), stackTrace: s));
    }
  }

  Future<void> logout() async {
    await client.clearToken();
    _user = null;
  }
}
