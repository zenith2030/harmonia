import 'dart:async';
import 'dart:developer';

import 'package:harmonia/auth/data/dtos/credentials.dart';
import 'package:harmonia/auth/data/dtos/register_user.dart';
import 'package:harmonia/auth/domain/entities/user.dart';
import 'package:harmonia/errors/http_error.dart';
import 'package:harmonia/shareds/client_http.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepository {
  static const String baseHttp = 'https://solutil.com.br/api/collections/users';

  User? _user;
  User? get currentUser => _user;

  final ClientHttp client;

  AuthRepository(this.client);

  final _streamController = StreamController<User?>();
  Stream<User?> get userObserve => _streamController.stream;

  AsyncResult<User> login(Credentials credentials) async {
    try {
      final result = await client.post(
        '$baseHttp/auth-with-password',
        body: {
          'identity': credentials.email,
          'password': credentials.password,
        },
      );
      if (result.statusCode == 200) {
        _user = User.fromJson((result.data['record'] as Map<String, dynamic>));
        final token = (result.data as Map<String, dynamic>)['token'];
        await client.setToken(_user, token);
        _streamController.add(_user);
        return Success(_user!);
      } else {
        final message = (result.data as Map<String, dynamic>)['message'];
        return Failure(LoginError(message: message));
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return Failure(LoginError(message: 'Erro ao realizar login'));
    }
  }

  AsyncResult<User> register(RegisterUser user) async {
    try {
      final result = await client.post('$baseHttp/records?fields=*', body: {
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'passwordConfirm': user.passwordConfirm,
      });
      if (result.statusCode == 200) {
        return Success(User.fromJson(result.data as Map<String, dynamic>));
      } else {
        final message = (result.data as Map<String, dynamic>)['message'];
        return Failure(LoginError(message: message));
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return Failure(LoginError(message: 'Erro ao registrar usuário'));
    }
  }

  AsyncResult<void> requestPasswordReset(String email) async {
    try {
      final result = await client.post(
        '$baseHttp/request-password-reset',
        body: {'email': email},
      );
      if (result.statusCode == 204) {
        return Success(Unit);
      } else {
        final message = (result.data as Map<String, dynamic>)['message'];
        return Failure(LoginError(message: message));
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return Failure(LoginError(message: 'Erro ao solicitar reset de senha'));
    }
  }

  Future<void> logout() async {
    await client.clearToken();
    _user = null;
    _streamController.add(null);
  }
}
