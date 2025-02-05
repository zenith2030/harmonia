import 'package:harmonia/auth/domain/dtos/credentials.dart';
import 'package:harmonia/auth/domain/dtos/register_user.dart';
import 'package:harmonia/auth/domain/entities/logged_user.dart';
import 'package:harmonia/auth/domain/entities/user.dart';
import 'package:result_dart/result_dart.dart';

abstract class AuthRepository {
  AsyncResult<LoggedUser> login(Credentials credentials);
  AsyncResult<User> register(RegisterUser user);
  AsyncResult<void> requestPasswordReset(String email);
  AsyncResult<void> logout();
  Stream<LoggedUser?> get userObserve;
  LoggedUser? get currentUser;
  AsyncResult<Unit> loadSavedUser();
}
