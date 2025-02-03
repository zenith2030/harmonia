import 'package:flutter/material.dart';
import 'package:harmonia/auth/data/dtos/credentials.dart';
import 'package:harmonia/auth/domain/entities/user.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

import '../../../auth/data/repositories/auth_repository.dart';

class LoginViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewmodel(this._authRepository);

  late final logincommand = Command1(_login);

  AsyncResult<User> _login(Credentials credentials) {
    return _authRepository.login(credentials);
  }
}
