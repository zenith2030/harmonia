import 'package:flutter/material.dart';
import 'package:harmonia/auth/domain/dtos/credentials.dart';
import 'package:harmonia/auth/domain/entities/logged_user.dart';
import 'package:harmonia/auth/domain/repositories/auth_repository.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class LoginViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewmodel(this._authRepository);

  late final logincommand = Command1(_login);

  AsyncResult<LoggedUser> _login(Credentials credentials) {
    return _authRepository.login(credentials);
  }
}
