import 'package:harmonia/player/domain/models/trilha_sonora.dart';
import 'package:harmonia/shareds/client_http.dart';
import 'package:harmonia/shareds/pocketbase_api.dart';

class TrilhaSonoraService {
  final ClientHttp client;
  late PocketBaseApi _trilhaService;
//  late PocketBaseApi _musicaService;

  TrilhaSonoraService(this.client) {
    _trilhaService = PocketBaseApi(collection: 'trilhas', client: client);
    //  _musicaService = PocketBaseApi(collection: 'musicas', client: client);
  }

  Future<List<TrilhaSonora>> getAll() async {
    try {
      final result = await _trilhaService.getAll();
      return result.map(TrilhaSonora.fromJson).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<TrilhaSonora> getById(String id) async {
    try {
      final result = await _trilhaService.getById(id);
      return TrilhaSonora.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<TrilhaSonora> create(Map<String, dynamic> model) async {
    final result = await _trilhaService.create(body: model);
    return TrilhaSonora.fromJson(result);
  }

  Future<TrilhaSonora> update(String id, Map<String, dynamic> model) async {
    final result = await _trilhaService.update(id, body: model);
    return TrilhaSonora.fromJson(result);
  }

  Future<void> delete(String id) async {
    await _trilhaService.delete(id);
  }
}
