import 'package:flutter/material.dart';
import 'package:harmonia/app/dependencies.dart';
import 'package:harmonia/player/data/repositories/trilha_sonora_repository.dart';
import 'package:harmonia/ui/player/pages/add_trilha_sonora.dart';
import 'package:harmonia/ui/player/widgets/gradient_background.dart';
import 'package:harmonia/ui/player/widgets/progress_widget.dart';

class MinhasTrilhasPage extends StatefulWidget {
  const MinhasTrilhasPage({super.key});

  @override
  State<MinhasTrilhasPage> createState() => _MinhasTrilhasPageState();
}

class _MinhasTrilhasPageState extends State<MinhasTrilhasPage> {
  @override
  Widget build(BuildContext context) {
    final repository = injector.get<TrilhaSonoraRepository>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Trilhas'),
      ),
      body: GradientBackground(
        child: FutureBuilder(
          future: repository.getTrilhas(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ProgressWidget();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: const Text('No data available'));
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
                      title:
                          Text(trilha.nome, style: TextStyle(fontSize: 18.0)),
                      subtitle: Text('Faixas: ${trilha.faixas.length}'),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTrilhaSonora(),
            ),
          );
        },
      ),
    );
  }
}
