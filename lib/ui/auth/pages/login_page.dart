import 'package:flutter/material.dart';
import 'package:harmonia/app/dependencies.dart';
import 'package:harmonia/auth/domain/dtos/credentials.dart';
import 'package:harmonia/auth/domain/validators/credentials_validator.dart';
import 'package:harmonia/shareds/widgets/custom_button.dart';
import 'package:harmonia/ui/auth/viewmodels/login_viewmodel.dart';
import 'package:harmonia/shareds/widgets/app_logo.dart';
import 'package:harmonia/shareds/widgets/custom_text_form_field.dart';
import 'package:harmonia/ui/player/widgets/gradient_background.dart';
import 'package:harmonia/widgets/text_title_button.dart';
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
              physics: ScrollPhysics(parent: BouncingScrollPhysics()),
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
                      return CustomButton(
                        onPressed: viewModel.logincommand.isRunning
                            ? null
                            : validLogin,
                        child: (viewModel.logincommand.isRunning)
                            ? const CircularProgressIndicator()
                            : const TextTitleButton('Entrar'),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/register'),
                        child: const TextTitleButton('Criar uma conta'),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/forgot-password'),
                        child: const TextTitleButton('Esqueci a senha'),
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
