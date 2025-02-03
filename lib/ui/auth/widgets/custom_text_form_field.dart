import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.validator,
    this.obscureText = false,
    required this.onChanged,
    required this.label,
    this.keyboardType = TextInputType.text,
  });

  final void Function(String? value)? onChanged;
  final String? Function(String? value)? validator;
  final bool obscureText;
  final String label;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
      obscureText: obscureText,
      validator: validator,
    );
  }
}
