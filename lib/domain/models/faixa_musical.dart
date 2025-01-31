class FaixaMusical {
  final String id;
  final String nome;
  final String duration;
  final String fileUrl;
  final List<Map<FaixaMusicalOptions, dynamic>> options;

  FaixaMusical({
    required this.id,
    required this.nome,
    required this.fileUrl,
    required this.duration,
    required this.options,
  });

  factory FaixaMusical.fromJson(Map<String, dynamic> json) {
    return FaixaMusical(
      id: json['id'],
      nome: json['nome'],
      fileUrl: json['fileUrl'],
      duration: json['duration'],
      options: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'fileUrl': fileUrl,
      'duracao': duration,
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
