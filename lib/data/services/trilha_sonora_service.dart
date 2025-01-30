import 'package:harmonia/domain/models/faixa_musical.dart';
import 'package:harmonia/domain/models/trilha_sonora.dart';
import '../../shareds/pocketbase_service.dart';

class TrilhaSonoraService {
  final _trilhaService = PocketBaseService('trilha_sonora');
  final _musicaService = PocketBaseService('musica');

  Future<List<TrilhaSonora>> getAll() async {
    try {
      final result = await _trilhaService.getAll();
      return result.items.map((e) {
        final item = TrilhaSonora.fromJson(e.data);
        e.data['faixas'].forEach((id) async {
          final musica = await _musicaService.getById(id);
          item.faixas.add(FaixaMusical.fromJson(musica.data));
        });
        return item;
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<TrilhaSonora> getById(String id) async {
    try {
      final result = await _trilhaService.getById(id);
      return TrilhaSonora.fromJson(result.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<TrilhaSonora> add(Map<String, dynamic> model) async {
    final result = await _trilhaService.add(model);
    return TrilhaSonora.fromJson(result.data);
  }

  Future<TrilhaSonora> update(String id, Map<String, dynamic> model) async {
    final result = await _trilhaService.update(id, model);
    return TrilhaSonora.fromJson(result.data);
  }

  Future<void> delete(String id) async {
    await _trilhaService.delete(id);
  }
}
