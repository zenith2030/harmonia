import 'package:flutter/material.dart';
import 'package:harmonia/app/dependencies.dart';
import 'package:harmonia/ui/auth/pages/forgot_password_page.dart';
import 'package:harmonia/ui/auth/pages/login_page.dart';
import 'package:harmonia/ui/auth/pages/register_page.dart';
import 'package:harmonia/ui/auth/pages/splash_page.dart';
import 'package:harmonia/ui/auth/viewmodels/splash_viewmodel.dart';
import 'package:harmonia/ui/player/pages/app_page.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: ThemeNotifier.themeMode(),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(
              splashViewmodel: injector.get<SplashViewmodel>(),
            ),
        '/home': (context) => const AppPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
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
