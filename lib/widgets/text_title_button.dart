import 'package:flutter/material.dart';

class TextTitleButton extends StatelessWidget {
  const TextTitleButton(this.label, {super.key, this.style});

  final String label;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: style ?? Theme.of(context).textTheme.titleMedium,
    );
  }
}
