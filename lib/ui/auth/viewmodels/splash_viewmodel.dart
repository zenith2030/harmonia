import 'package:flutter/material.dart';
import 'package:harmonia/auth/domain/entities/logged_user.dart';
import 'package:harmonia/auth/domain/repositories/auth_repository.dart';

class SplashViewmodel extends ChangeNotifier {
  SplashViewmodel(AuthRepository authRepository)
      : _authRepository = authRepository;

  bool get isLogged => _user != null;
  LoggedUser? _user;

  final AuthRepository _authRepository;

  init() async {
    _authRepository.userObserve.listen((user) {
      _user = user;
      notifyListeners();
    });
    await _authRepository.loadSavedUser();
    notifyListeners();
  }
}
