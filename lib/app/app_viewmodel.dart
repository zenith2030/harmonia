import 'package:flutter/material.dart';
import 'package:harmonia/auth/domain/entities/logged_user.dart';
import 'package:harmonia/auth/domain/repositories/auth_repository.dart';

class AppViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoggedUser? _user;
  LoggedUser? get user => _user;

  AppViewModel(this._authRepository) {
    _authRepository.userObserve.listen((user) {
      _user = user;
      notifyListeners();
    });
  }
}
