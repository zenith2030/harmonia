import 'package:flutter/material.dart';
import 'package:harmonia/player/domain/models/trilha_sonora.dart';

import '../../../player/data/repositories/trilha_sonora_repository.dart';
import 'progress_widget.dart';

class TrilhaSonoraList extends StatelessWidget {
  const TrilhaSonoraList({
    super.key,
    required this.repository,
  });

  final TrilhaSonoraRepository repository;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TrilhaSonora>>(
      future: repository.getTrilhas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ProgressWidget();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available');
        } else {
          final trilhas = snapshot.data!;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(5.0),
              itemCount: trilhas.length,
              itemBuilder: (context, index) {
                final trilha = trilhas[index];
                return ListTile(
                  minTileHeight: 60.0,
                  minLeadingWidth: 60.0,
                  minVerticalPadding: 5.0,
                  horizontalTitleGap: 10.0,
                  dense: true,
                  leading: trilha.imagemUrl == null
                      ? null
                      : Image.network(
                          trilha.imagemUrl!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                  title: Text(trilha.nome, style: TextStyle(fontSize: 18.0)),
                  subtitle: Text('Faixas: ${trilha.faixas.length}'),
                );
              },
            ),
          );
        }
      },
    );
  }
}
