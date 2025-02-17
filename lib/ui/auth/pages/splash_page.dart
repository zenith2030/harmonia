import 'package:flutter/material.dart';
import 'package:harmonia/app/dependencies.dart';
import 'package:harmonia/app/router.dart';
import 'package:harmonia/app/routes.dart';
import 'package:harmonia/shareds/widgets/app_logo.dart';
import 'package:harmonia/ui/player/widgets/gradient_background.dart';
import 'package:harmonia/ui/auth/viewmodels/splash_viewmodel.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashViewmodel _splashViewmodel = injector.get<SplashViewmodel>();
  @override
  void initState() {
    super.initState();
    _splashViewmodel.addListener(() {
      if (_splashViewmodel.isLogged) {
        nav.go(Routes.home);
      } else {
        nav.go(Routes.login);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _splashViewmodel.init();
    });
  }

  @override
  void dispose() {
    debugPrint('dispose _SplashPageState');
    _splashViewmodel.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Theme.of(context).colorScheme.primary,
      home: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLogo(size: 200.0),
              SizedBox(height: 60.0),
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
