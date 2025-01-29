import 'package:harmonia/data/dtos/trilha_sonora_dtos.dart';
import 'package:harmonia/domain/models/faixa_musical.dart';
import 'package:harmonia/domain/models/trilha_sonora.dart';

abstract class TrilhaSonoraRepository {
  Future<List<TrilhaSonora>> getTrilhas();
  Future<TrilhaSonora> getTrilha(String id);
  Future<TrilhaSonora> addTrilha(TrilhaSonoraCreate trilha);
  Future<void> updateTrilha(TrilhaSonora trilha);
  Future<void> deleteTrilha(String id);

  // Faixa
  Future<void> addFaixa(String trilhaId, FaixaMusical faixa);
  Future<void> updateFaixa(String trilhaId, FaixaMusical faixa);
  Future<void> deleteFaixa(String trilhaId, String faixaId);
}
