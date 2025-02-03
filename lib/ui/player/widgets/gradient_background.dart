import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget? child;
  final EdgeInsets padding;
  const GradientBackground({
    super.key,
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    return SafeArea(
      child: Container(
        padding: padding,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0.0, 1.0],
            colors: [
              themeColors.tertiaryContainer,
              themeColors.secondaryContainer,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: child,
      ),
    );
  }
}
