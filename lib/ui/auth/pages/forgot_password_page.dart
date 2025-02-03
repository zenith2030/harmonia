import 'package:flutter/material.dart';
import 'package:harmonia/app/dependencies.dart';
import 'package:harmonia/auth/domain/dtos/credentials.dart';
import 'package:harmonia/auth/domain/repositories/auth_repository.dart';
import 'package:harmonia/auth/domain/validators/credentials_validator.dart';
import 'package:harmonia/ui/auth/widgets/custom_text_form_field.dart';
import 'package:harmonia/ui/player/widgets/gradient_background.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final auth = injector.get<AuthRepository>();
  final credential = Credentials.empty();
  final formKey = GlobalKey<FormState>();
  final validator = CredentialsValidator();

  recuperarPassword() async {
    if (formKey.currentState!.validate()) {
      final result = await auth.requestPasswordReset(credential.email);
      result.fold(
        (user) => Navigator.of(context).pushReplacementNamed('/login'),
        (failure) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.toString()),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Recuperar senha')),
        body: GradientBackground(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  CustomTextFormField(
                    label: 'Email',
                    onChanged: (value) => credential.email = value ?? '',
                    validator: validator.byField(credential, 'email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16.0),
                  CustomButton(
                    onPressed: recuperarPassword,
                    child: const Text('Recuperar senha'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
