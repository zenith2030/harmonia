import 'package:harmonia/domain/models/faixa_musical.dart';

class TrilhaSonoraUpdate {
  String nome;
  String imagemUrl;

  TrilhaSonoraUpdate(
    this.nome,
    this.imagemUrl,
  );

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'imageUrl': imagemUrl,
    };
  }
}

class TrilhaSonoraCreate extends TrilhaSonoraUpdate {
  List<FaixaMusical> faixas;

  TrilhaSonoraCreate(
    super.nome,
    super.imagemUrl,
    this.faixas,
  );

  factory TrilhaSonoraCreate.empty() {
    return TrilhaSonoraCreate('', '', []);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'imageUrl': imagemUrl,
      'faixas': faixas.map((faixa) => faixa.toJson()).toList(),
    };
  }
}
