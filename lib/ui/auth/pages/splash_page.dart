import 'package:flutter/material.dart';
import 'package:harmonia/shareds/widgets/app_logo.dart';
import 'package:harmonia/ui/player/widgets/gradient_background.dart';
import 'package:harmonia/ui/auth/viewmodels/splash_viewmodel.dart';

class SplashPage extends StatefulWidget {
  final SplashViewmodel _splashViewmodel;

  const SplashPage({super.key, required SplashViewmodel splashViewmodel})
      : _splashViewmodel = splashViewmodel;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    widget._splashViewmodel.addListener(() {
      if (widget._splashViewmodel.isLogged) {
        Navigator.pushNamed(context, '/home');
      } else {
        Navigator.pushNamed(context, '/login');
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._splashViewmodel.init();
    });
  }

  @override
  void dispose() {
    widget._splashViewmodel.removeListener(() {});
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
