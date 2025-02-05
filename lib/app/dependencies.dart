import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';
import 'package:harmonia/auth/data/repositories/auth_repository_pocketbase.dart';
import 'package:harmonia/auth/domain/repositories/auth_repository.dart';
import 'package:harmonia/player/data/repositories/trilha_sonora_impl_repository.dart';
import 'package:harmonia/player/data/repositories/trilha_sonora_repository.dart';
import 'package:harmonia/player/data/services/trilha_sonora_service.dart';
import 'package:harmonia/shareds/services/client_http.dart';
import 'package:harmonia/shareds/services/local_storage.dart';
import 'package:harmonia/ui/auth/viewmodels/login_viewmodel.dart';
import 'package:harmonia/ui/auth/viewmodels/splash_viewmodel.dart';

final injector = AutoInjector();

void setupDependencies() {
  injector.addInstance(Dio());
  injector.addSingleton(LocalStorage.new);
  injector.addLazySingleton(ClientHttp.new);
  injector.addLazySingleton<AuthRepository>(AuthRepositoryPocketbase.new);
  injector.addLazySingleton<TrilhaSonoraRepository>(
    TrilhaSonoraImplRepository.new,
  );
  injector.addLazySingleton(TrilhaSonoraService.new);

  injector.addSingleton(LoginViewmodel.new);
  injector.addSingleton(SplashViewmodel.new);
  injector.commit();
}
