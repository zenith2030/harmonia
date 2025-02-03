import 'package:flutter/material.dart';
import 'package:harmonia/app/dependencies.dart';
import 'package:harmonia/auth/domain/dtos/credentials.dart';
import 'package:harmonia/auth/domain/validators/credentials_validator.dart';
import 'package:harmonia/ui/auth/viewmodels/login_viewmodel.dart';
import 'package:harmonia/ui/auth/widgets/app_logo.dart';
import 'package:harmonia/ui/auth/widgets/custom_text_form_field.dart';
import 'package:harmonia/ui/player/widgets/gradient_background.dart';
import 'package:result_command/result_command.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final viewModel = injector.get<LoginViewmodel>();
  final credentials = Credentials.empty();
  final validator = CredentialsValidator();
  final formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    viewModel.logincommand.addListener(_listenable);
  }

  _listenable() {
    if (viewModel.logincommand.isFailure) {
      final failure = viewModel.logincommand.value as FailureCommand;
      final snacker = SnackBar(
        backgroundColor: Colors.red,
        content: Text(failure.error.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snacker);
    }
  }

  @override
  dispose() {
    viewModel.logincommand.removeListener(_listenable);
    super.dispose();
  }

  validLogin() async {
    if (formKey.currentState!.validate()) {
      viewModel.logincommand.execute(credentials);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GradientBackground(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  AppLogo(size: 200.0),
                  SizedBox(height: 20.0),
                  CustomTextFormField(
                    label: 'Email',
                    onChanged: credentials.setEmail,
                    validator: validator.byField(credentials, 'email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.0),
                  CustomTextFormField(
                    label: 'Senha',
                    onChanged: credentials.setPassword,
                    validator: validator.byField(credentials, 'password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  ListenableBuilder(
                    listenable: viewModel.logincommand,
                    builder: (context, _) {
                      debugPrint(viewModel.logincommand.value.toString());
                      //debugPrint(formKey.currentState!.validate().toString());
                      return CustomButton(
                        onPressed: viewModel.logincommand.isRunning
                            ? null
                            : validLogin,
                        child: (viewModel.logincommand.isRunning)
                            ? const CircularProgressIndicator()
                            : const Text('Entrar'),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/register'),
                        child: const Text('Criar uma conta'),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/forgot-password'),
                        child: const Text('Esqueci a senha'),
                      ),
                    ],
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
