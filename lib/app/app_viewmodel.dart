import 'package:flutter/material.dart';
import 'package:harmonia/auth/data/repositories/auth_repository.dart';
import 'package:harmonia/auth/domain/entities/user.dart';

class AppViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  User? _user;
  User? get user => _user;

  AppViewModel(this._authRepository) {
    _authRepository.userObserve.listen((user) {
      _user = user;
      notifyListeners();
    });
  }
}
