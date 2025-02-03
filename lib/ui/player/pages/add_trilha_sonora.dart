import 'package:flutter/material.dart';
import 'package:harmonia/player/data/dtos/trilha_sonora_dtos.dart';
import 'package:harmonia/ui/player/widgets/gradient_background.dart';
import 'package:harmonia/ui/player/widgets/upload_image.dart';

class AddTrilhaSonora extends StatelessWidget {
  const AddTrilhaSonora({super.key});

  @override
  Widget build(BuildContext context) {
    final trilha = TrilhaSonoraCreate.empty();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Trilha Sonora'),
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: trilha.nome,
                  decoration: InputDecoration(
                      labelText: 'Título', border: OutlineInputBorder()),
                ),
                TextFormField(
                  initialValue: trilha.imagemUrl,
                  decoration: InputDecoration(
                      labelText: 'Imagem',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.image_search_outlined))),
                ),
                UploadImage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
