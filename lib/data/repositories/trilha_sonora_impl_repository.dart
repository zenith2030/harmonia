import 'package:harmonia/data/dtos/trilha_sonora_dtos.dart';
import 'package:harmonia/data/repositories/trilha_sonora_repository.dart';
import 'package:harmonia/data/services/trilha_sonora_service.dart';
import 'package:harmonia/domain/models/faixa_musical.dart';
import 'package:harmonia/domain/models/trilha_sonora.dart';

class TrilhaSonoraImplRepository implements TrilhaSonoraRepository {
  final List<TrilhaSonora> _trilhas = [];
  final TrilhaSonoraService _trilhaService;

  TrilhaSonoraImplRepository(this._trilhaService);

  @override
  Future<List<TrilhaSonora>> getTrilhas() async {
    if (_trilhas.isNotEmpty) return _trilhas;
    final result = await _trilhaService.getAll();
    _trilhas.addAll(result);
    return _trilhas;
  }

  @override
  Future<void> addFaixa(String trilhaId, FaixaMusical faixa) async {
    final trilha = _trilhas.firstWhere((t) => t.id == trilhaId);
    trilha.faixas.add(faixa);
    await _trilhaService.update(trilha.id, trilha.toJson());
  }

  @override
  Future<TrilhaSonora> addTrilha(TrilhaSonoraCreate trilha) async {
    try {
      final trilhaModel = await _trilhaService.create(trilha.toJson());
      _trilhas.add(trilhaModel);
      return trilhaModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteFaixa(String trilhaId, String faixaId) async {
    final trilha = _trilhas.firstWhere((t) => t.id == trilhaId);
    final faixa = trilha.faixas.firstWhere((f) => f.id == faixaId);
    trilha.faixas.remove(faixa);
    await _trilhaService.update(trilha.id, trilha.toJson());
  }

  @override
  Future<void> deleteTrilha(String id) async {
    final trilha = _trilhas.firstWhere((t) => t.id == id);
    await _trilhaService.delete(id);
    _trilhas.remove(trilha);
  }

  @override
  Future<TrilhaSonora> getTrilha(String id) async {
    try {
      final result = _trilhas.firstWhere((t) => t.id == id);
      return Future.value(result);
    } catch (e) {
      final trilha = await _trilhaService.getById(id);
      _trilhas.add(trilha);
      return Future.value(trilha);
    }
  }

  @override
  Future<void> updateFaixa(String trilhaId, FaixaMusical faixa) async {
    try {
      final trilha = _trilhas.firstWhere((t) => t.id == trilhaId);
      final existingFaixa = trilha.faixas.firstWhere((f) => f.id == faixa.id);
      trilha.faixas.remove(existingFaixa);
      await _trilhaService.update(trilha.id, trilha.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTrilha(TrilhaSonora trilha) async {
    try {
      var trilhaModel = _trilhas.firstWhere((t) => t.id == trilha.id);
      trilhaModel = trilhaModel.copyWith(trilha.toJson());
      await _trilhaService.update(trilhaModel.id, trilhaModel.toJson());
      return;
    } catch (e) {
      rethrow;
    }
  }
}
