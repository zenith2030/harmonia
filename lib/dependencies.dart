import 'package:dio/dio.dart';
import 'package:harmonia/data/auth/auth_service.dart';
import 'package:harmonia/data/repositories/trilha_sonora_impl_repository.dart';
import 'package:harmonia/data/repositories/trilha_sonora_repository.dart';
import 'package:harmonia/data/services/trilha_sonora_service.dart';
import 'package:harmonia/main.dart';
import 'package:harmonia/shareds/client_http.dart';

class Dependencies {
  Dependencies() {
    injector.addInstance<Dio>(Dio());
    injector.addLazySingleton<ClientHttp>(ClientHttp.new);
    injector.addLazySingleton<AuthService>(AuthService.new);
    injector.addLazySingleton<TrilhaSonoraRepository>(
      TrilhaSonoraImplRepository.new,
    );
    injector.addLazySingleton<TrilhaSonoraService>(TrilhaSonoraService.new);
    injector.commit();
  }
}
