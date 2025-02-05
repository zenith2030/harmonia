import 'dart:developer';

import 'package:harmonia/errors/http_error.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  AsyncResult<String> saveData(String key, String value) async {
    try {
      final shared = await SharedPreferences.getInstance();
      shared.setString(key, value);
      return Success(value);
    } catch (e) {
      log('$runtimeType: ${e.toString()}');
      return Failure(LocalStorageError(message: e.toString()));
    }
  }

  AsyncResult<String> getData(String key) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final value = shared.getString(key);
      if (value == null) {
        return Failure(LocalStorageError(message: 'Chave $key não encontrada'));
      }
      return Success(value);
    } catch (e) {
      log('$runtimeType: ${e.toString()}');
      return Failure(LocalStorageError(message: e.toString()));
    }
  }

  AsyncResult<Unit> removeData(String key) async {
    try {
      final shared = await SharedPreferences.getInstance();
      shared.remove(key);
      return Success.unit();
    } catch (e) {
      log('$runtimeType: ${e.toString()}');
      return Failure(LocalStorageError(message: 'Erro ao remover dados'));
    }
  }
}
