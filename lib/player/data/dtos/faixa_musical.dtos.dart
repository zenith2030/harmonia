import 'package:harmonia/player/domain/models/faixa_musical.dart';

class FaixaMusicalUpdate {
  final String name;
  final String streamUrl;
  final List<Map<FaixaMusicalOptions, dynamic>> options;

  FaixaMusicalUpdate({
    required this.name,
    required this.streamUrl,
    required this.options,
  });
}

class FaixaMusicalCreate extends FaixaMusicalUpdate {
  FaixaMusicalCreate({
    required super.name,
    required super.streamUrl,
    required super.options,
  });
}
