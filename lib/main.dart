import 'package:flutter/material.dart';
import 'package:harmonia/app/app.dart';
import 'package:harmonia/ui/auth/pages/splash_page.dart';
import 'app/dependencies.dart';

void main() async {
  runApp(const SplashPage());
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  await carregarMusicas();
  runApp(const App());
}
