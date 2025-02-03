import 'package:flutter/material.dart';
import 'package:harmonia/app/app_viewmodel.dart';
import 'package:harmonia/app/dependencies.dart';
import 'package:harmonia/ui/auth/widgets/app_logo.dart';
import 'package:harmonia/ui/player/widgets/gradient_background.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final appViewModel = injector.get<AppViewModel>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appViewModel.addListener(listener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listener();
    });
  }

  void listener() {
    if (appViewModel.user != null) {
      Navigator.of(context).pushNamed('/home');
    } else {
      Navigator.of(context).pushNamed('/login');
    }
  }

  @override
  void dispose() {
    appViewModel.removeListener(listener);
    super.dispose();
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
                AppLogo(size: 200.0),
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
