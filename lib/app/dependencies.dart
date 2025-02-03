import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';
import 'package:harmonia/app/app_viewmodel.dart';
import 'package:harmonia/auth/data/repositories/auth_repository.dart';
import 'package:harmonia/player/data/repositories/trilha_sonora_impl_repository.dart';
import 'package:harmonia/player/data/repositories/trilha_sonora_repository.dart';
import 'package:harmonia/player/data/services/trilha_sonora_service.dart';
import 'package:harmonia/shareds/client_http.dart';
import 'package:harmonia/ui/auth/viewmodels/login_viewmodel.dart';

final injector = AutoInjector();

void setupDependencies() {
  injector.addInstance(Dio());
  injector.addLazySingleton(ClientHttp.new);
  injector.addLazySingleton(AuthRepository.new);
  injector.addLazySingleton<TrilhaSonoraRepository>(
    TrilhaSonoraImplRepository.new,
  );
  injector.addLazySingleton(TrilhaSonoraService.new);

  injector.addSingleton(LoginViewmodel.new);
  injector.addSingleton(AppViewModel.new);
  injector.commit();
}
