import 'package:flutter/material.dart';
import 'package:harmonia/data/auth/auth_service.dart';
import 'package:harmonia/data/auth/login_dto.dart';
import 'package:harmonia/data/auth/login_validator.dart';
import 'package:harmonia/main.dart';
import 'package:harmonia/ui/auth/widgets/app_logo.dart';
import 'package:harmonia/ui/widgets/gradient_background.dart';
import 'package:result_dart/result_dart.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = injector.get<AuthService>();
  final login = LoginDto.empty();
  final formKey = GlobalKey<FormState>();
  final validator = LoginValidator();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: GradientBackground(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLogo(size: 200.0),
                  SizedBox(height: 16.0),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onChanged: (value) => login.email = value,
                    keyboardType: TextInputType.emailAddress,
                    validator: validator.byField(login, 'email'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onChanged: (value) => login.password = value,
                    obscureText: true,
                    validator: validator.byField(login, 'password'),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final result =
                              auth.login(login.email, login.password);
                          result.fold(
                            (failure) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(failure.toString())),
                            ),
                            (user) =>
                                Navigator.of(context).pushReplacementNamed(
                              '/home',
                            ),
                          );
                        }
                      },
                      child: Text('Login'),
                    ),
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
