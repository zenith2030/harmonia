import 'package:harmonia/domain/models/faixa_musical.dart';

class TrilhaSonora {
  final String id;
  final String nome;
  final String? imagemUrl;
  final List<FaixaMusical> faixas;

  TrilhaSonora({
    required this.id,
    required this.nome,
    this.imagemUrl,
    this.faixas = const [],
  });

  factory TrilhaSonora.fromJson(Map<String, dynamic> json) {
    return TrilhaSonora(
      id: json['id'],
      nome: json['nome'],
      imagemUrl: json['imageUrl'],
      faixas:
          FaixaMusical.toList((json['faixas'] as List<Map<String, dynamic>>)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'imageUrl': imagemUrl,
      'faixas': FaixaMusical.toMapList(faixas),
    };
  }

  TrilhaSonora copyWith(Map<String, dynamic> model) {
    return TrilhaSonora(
      id: model['id'] ?? id,
      nome: model['nome'] ?? nome,
      imagemUrl: model['imageUrl'] ?? imagemUrl,
      faixas: model['faixas'] ?? faixas,
    );
  }
}
