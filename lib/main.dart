import 'package:flutter/material.dart';
import 'package:harmonia/data/repositories/trilha_sonora_impl_repository.dart';
import 'package:harmonia/data/repositories/trilha_sonora_repository.dart';
import 'package:harmonia/data/services/trilha_sonora_service.dart';
import 'package:harmonia/ui/pages/app_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late TrilhaSonoraRepository repository;

  @override
  void initState() {
    super.initState();
    repository = TrilhaSonoraImplRepository(TrilhaSonoraService());
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TrilhaSonoraRepository>(
          create: (_) => repository,
        ),
      ],
      child: MaterialApp(
        title: 'Mestre de Harmonia',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange,
            brightness: ThemeNotifier.themeMode,
          ),
          useMaterial3: true,
        ),
        home: const AppPage(),
      ),
    );
  }
}

class ThemeNotifier extends ChangeNotifier {
  static Brightness _themeMode = Brightness.light;

  static Brightness get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = (_themeMode == Brightness.light) //
        ? Brightness.dark
        : Brightness.light;
    notifyListeners();
  }
}
