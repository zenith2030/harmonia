import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size,
    this.textColor,
  });

  final double? size;
  final FlutterLogoStyle style = FlutterLogoStyle.stacked;
  final Color? textColor;
  final duration = const Duration(seconds: 1);
  final curve = Curves.linear;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double? iconSize = size ?? iconTheme.size;
    return AnimatedContainer(
      width: iconSize,
      height: iconSize,
      duration: duration,
      curve: curve,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
