import 'package:flutter/material.dart';

class PerfilUser extends StatelessWidget {
  const PerfilUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuáeio'),
      ),
      body: const Center(
        child: Text('Perfil do usuário'),
      ),
    );
  }
}
