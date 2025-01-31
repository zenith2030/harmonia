import 'package:flutter/material.dart';
import 'package:harmonia/data/auth/auth_service.dart';
import 'package:harmonia/data/auth/user_dtos.dart';
import 'package:harmonia/main.dart';
import 'package:harmonia/ui/auth/widgets/app_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = injector.get<AuthService>();
    final user = UserDtos(email: '', password: '');
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLogo(size: 120.0),
              SizedBox(height: 100.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                onChanged: (value) => user.email = value,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                onChanged: (value) => user.password = value,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  auth.login(user.email, user.password);
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
