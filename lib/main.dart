import 'package:flutter/material.dart';
import 'package:harmonia/app/app.dart';
import 'app/dependencies.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(MaterialApp(home: const App()));
}
