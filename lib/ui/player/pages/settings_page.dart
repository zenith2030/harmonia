import 'package:flutter/material.dart';
import 'package:harmonia/app/app.dart';
import 'package:harmonia/app/dependencies.dart';
import 'package:harmonia/auth/data/repositories/auth_repository.dart';
import 'package:harmonia/ui/player/widgets/gradient_background.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        ],
      ),
      body: GradientBackground(
        child: Center(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.color_lens),
                title: Text('Thema'),
                trailing: IconButton(
                  icon: Icon(ThemeNotifier.themeMode() == Brightness.light
                      ? Icons.dark_mode
                      : Icons.light_mode),
                  onPressed: () {
                    ThemeNotifier().toggleTheme();
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Musicas'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Sair'),
                onTap: () {
                  injector.get<AuthRepository>().logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
