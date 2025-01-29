class FaixaMusical {
  final String id;
  final String nome;
  final String streamUrl;
  final String duracao;
  final List<Map<FaixaMusicalOptions, dynamic>> options;

  FaixaMusical({
    required this.id,
    required this.nome,
    required this.streamUrl,
    required this.duracao,
    required this.options,
  });

  factory FaixaMusical.fromJson(Map<String, dynamic> json) {
    return FaixaMusical(
      id: json['id'],
      nome: json['nome'],
      streamUrl: json['streamUrl'],
      duracao: json['duracao'],
      options: json['options'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'streamUrl': streamUrl,
      'duracao': duracao,
      'options': options,
    };
  }

  static List<Map<String, dynamic>> toMapList(List<FaixaMusical> faixas) =>
      faixas.map((faixa) => faixa.toJson()).toList();

  static List<FaixaMusical> toList(List<Map<String, dynamic>> json) {
    return json //
        .map(FaixaMusical.fromJson)
        .toList();
  }
}

enum FaixaMusicalOptions {
  loop,
  volume,
  start,
}
