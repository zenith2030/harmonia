import 'package:flutter/material.dart';
import 'package:harmonia/app/dependencies.dart';
import 'package:harmonia/auth/data/repositories/auth_repository.dart';
import 'package:harmonia/auth/data/dtos/register_user.dart';
import 'package:harmonia/auth/data/validators/register_user_validator.dart';
import 'package:harmonia/ui/player/widgets/gradient_background.dart';
import 'package:harmonia/ui/auth/widgets/custom_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final auth = injector.get<AuthRepository>();
  final user = RegisterUser.empty();
  final formKey = GlobalKey<FormState>();
  final validator = RegisterUserValidator();

  registrarUser() async {
    if (formKey.currentState!.validate()) {
      final result = await auth.register(user);
      result.fold(
        (user) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text('Usuário registrado com sucesso!'),
          ));
          Navigator.of(context).pushReplacementNamed('/login');
        },
        (failure) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
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
        appBar: AppBar(title: const Text('Registrar')),
        body: GradientBackground(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    label: 'Nome',
                    onChanged: (value) => user.name = value ?? '',
                    validator: validator.byField(user, 'name'),
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 16.0),
                  CustomTextFormField(
                    label: 'Email',
                    onChanged: (value) => user.email = value ?? '',
                    validator: validator.byField(user, 'email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.0),
                  CustomTextFormField(
                    label: 'Senha',
                    onChanged: (value) => user.password = value ?? '',
                    validator: validator.byField(user, 'password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    label: 'Confirme a Senha',
                    onChanged: (value) => user.passwordConfirm = value ?? '',
                    validator: validator.byField(user, 'passwordConfirm'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  CustomButton(
                    onPressed: registrarUser,
                    child: const Text('Registrar'),
                  ),
                  const SizedBox(height: 4.0),
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
