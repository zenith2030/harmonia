import 'package:auto_injector/auto_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:harmonia/shareds/lucid_localization_delegate.dartLucid.dart';
import 'ui/pages/app_page.dart';
import 'ui/auth/pages/login_page.dart';
import 'ui/auth/pages/splash_page.dart';
import 'dependencies.dart';

final injector = AutoInjector();
final globalLocale = ValueNotifier(const Locale('pt'));
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //LucidValidation.global.languageManager = CustomLanguageManager();
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
    return Builder(builder: (context) {
      return ValueListenableBuilder<Locale>(
          valueListenable: globalLocale,
          builder: (context, value, _) {
            return MaterialApp(
              title: 'Mestre de Harmonia',
              debugShowCheckedModeBanner: false,
              locale: value,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('pt', 'BR'),
              ],
              localizationsDelegates: const [
                LucidLocalizationDelegate.delegate,
              ],
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
          });
    });
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

// class CustomLanguageManager extends LanguageManager {
//   CustomLanguageManager() {
//     addTranslation(
//         Culture('pt', 'BR'), Language.code.equalTo, 'Custom message here');
//   }
// }
