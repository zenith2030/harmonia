import 'package:flutter/material.dart';
import 'package:harmonia/data/auth/auth_service.dart';
import 'package:harmonia/main.dart';
import 'package:harmonia/ui/auth/widgets/app_logo.dart';
import 'package:harmonia/ui/widgets/gradient_background.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final auth = injector.get<AuthService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 3), () {});
      if (auth.currentUser != null) {
        Navigator.of(context).pushReplacementNamed('/app');
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GradientBackground(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppLogo(size: 120.0),
                SizedBox(height: 60.0),
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
