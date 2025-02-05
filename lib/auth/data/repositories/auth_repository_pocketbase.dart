import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:harmonia/auth/domain/dtos/credentials.dart';
import 'package:harmonia/auth/domain/dtos/register_user.dart';
import 'package:harmonia/auth/domain/entities/logged_user.dart';
import 'package:harmonia/auth/domain/entities/user.dart';
import 'package:harmonia/auth/domain/repositories/auth_repository.dart';
import 'package:harmonia/errors/http_error.dart';
import 'package:harmonia/shareds/services/client_http.dart';
import 'package:harmonia/shareds/services/local_storage.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepositoryPocketbase implements AuthRepository {
  static const String baseHttp = 'https://solutil.com.br/api/collections/users';
  static const String storageKeyLoggedUser = 'loggedUser';
  final ClientHttp client;
  final LocalStorage localStorage;

  AuthRepositoryPocketbase(this.client, this.localStorage);

  LoggedUser? _loggedUser;
  final _streamController = StreamController<LoggedUser?>();

  @override
  LoggedUser? get currentUser => _loggedUser;

  @override
  Stream<LoggedUser?> get userObserve => _streamController.stream;

  @override
  AsyncResult<Unit> loadSavedUser() async {
    final savedUserJson = await localStorage.getData(storageKeyLoggedUser);
    return savedUserJson.fold((success) {
      final savedUserMap = jsonDecode(success);
      final user = LoggedUser.fromJson(savedUserMap);
      _streamController.add(user);
      return Success(unit);
    }, (failure) {
      _streamController.add(null);
      return Success(unit);
    });
  }

  @override
  AsyncResult<LoggedUser> login(Credentials credentials) async {
    try {
      final result = await client.post(
        '$baseHttp/auth-with-password',
        body: {
          'identity': credentials.email,
          'password': credentials.password,
        },
      );
      if (result.statusCode == 200) {
        final data = result.data as Map<String, dynamic>;
        final logged = LoggedUser.fromJson(data['record']);
        _loggedUser = logged.copyWith({
          'token': data['token'] ?? '',
          'refreshToken': data['refreshToken'] ?? '',
        });

        await client.setToken(_loggedUser);
        await localStorage.saveData(
          storageKeyLoggedUser,
          jsonEncode(_loggedUser!.toJson()),
        );
        _streamController.add(_loggedUser);
        return Success(_loggedUser!);
      } else {
        final message = (result.data as Map<String, dynamic>)['message'];
        return Failure(LoginError(message: message));
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return Failure(LoginError(message: 'Erro ao realizar login'));
    }
  }

  @override
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

  @override
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

  @override
  AsyncResult<Unit> logout() async {
    try {
      await client.clearToken();
      _loggedUser = null;
      _streamController.add(null);
      await localStorage.removeData(storageKeyLoggedUser);
      return Success(unit);
    } catch (e) {
      log(e.toString());
      return Failure(LoginError(message: 'Erro ao realizar logout'));
    }
  }
}
