import 'package:auto_injector/auto_injector.dart';
import 'package:flutter/material.dart';
import 'package:harmonia/ui/auth/pages/login_page.dart';
import 'package:harmonia/ui/auth/pages/splash_page.dart';
import 'dependencies.dart';
import 'ui/pages/app_page.dart';

final injector = AutoInjector();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Dependencies();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mestre de Harmonia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: ThemeNotifier.themeMode(),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const AppPage(),
        '/login': (context) => const LoginPage(),
      },
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
