import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.child,
    this.heightSize = 55.0,
    this.widthSize = double.infinity,
    this.colorButton,
  });

  final VoidCallback? onPressed;
  final Widget? child;
  final double heightSize;
  final double widthSize;
  final Color? colorButton;

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    final color = colorButton ?? themeColors.primaryContainer;
    return SizedBox(
      height: heightSize,
      width: widthSize,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(color),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
