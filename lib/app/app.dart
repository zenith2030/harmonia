import 'package:flutter/material.dart';
import 'package:harmonia/app/router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mestre de Harmonia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: ThemeNotifier.themeMode(),
        ),
        useMaterial3: true,
      ),
      // routerConfig: router(injector.get<AuthRepository>()),
      routerDelegate: nav.routerDelegate,
      routeInformationParser: nav.routeInformationParser,
      routeInformationProvider: nav.routeInformationProvider,
    );
  }
}

class ThemeNotifier extends ChangeNotifier {
  static Brightness _themeMode = Brightness.light;

  static Brightness themeMode() => _themeMode;

  void toggleTheme() {
    _themeMode = (_themeMode == Brightness.light) //
        ? Brightness.dark
        : Brightness.light;
    notifyListeners();
  }
}
