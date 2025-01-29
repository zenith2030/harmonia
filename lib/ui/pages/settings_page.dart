import 'package:flutter/material.dart';
import 'package:harmonia/main.dart';
import 'package:harmonia/ui/widgets/gradient_background.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: GradientBackground(
        child: Center(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.color_lens),
                title: Text('Thema'),
                trailing: IconButton(
                  icon: Icon(ThemeNotifier.themeMode == Brightness.light
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
            ],
          ),
        ),
      ),
    );
  }
}
