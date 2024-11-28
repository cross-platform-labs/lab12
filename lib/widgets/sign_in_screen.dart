import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './sign_up_screen.dart';
import 'reset_password_screen.dart';
import '../config/theme_config.dart';
import 'package:dio/dio.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Будь ласка, введіть логін';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Будь ласка, введіть пароль';
    }
    if (value.length < 7) {
      return 'Пароль повинен містити щонайменше 7 символів';
    }
    return null;
  }
  Future<void> _sendData() async {
    final dio = Dio();
    const String url = 'https://lab12.requestcatcher.com/';
    final response = await dio.post(url, data: {
      'login': _loginController.text,
      'password': _passwordController.text,
    });
    if (kDebugMode) {
      print(response.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Google-flutter-logo.svg/1024px-Google-flutter-logo.svg.png",
                  width: 200,
                ),
              ),
              const SizedBox(height: 20),
              const Text("Login", style: AppTextStyles.bodyLarge),
              TextFormField(
                controller: _loginController,
                decoration: const InputDecoration(
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              const Text("Password", style: AppTextStyles.bodyLarge),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  SignupScreen(),
                      ),
                    );
                  },
                  child: const Text("Sign up"),
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _sendData();
                            showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return const AlertDialog(
                                  title: Text('Message'),
                                  content: Text("Login is successful!"),
                                );
                              },
                            );
                          }
                        },
                        child: const Text("Login"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  ResetPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text("Reset password"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}