import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/theme_config.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Будь ласка, введіть електронну адресу';
    }
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Будь ласка, введіть правильну електронну адресу';
    }
    return null;
  }

  String? _validateLogin(String? value) {
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
      'email': _emailController.text,
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
              const Center(
                child: Text("Sign Up", style: AppTextStyles.displayLarge),
              ),
              const SizedBox(height: 20),
              const Text("Email", style: AppTextStyles.bodyLarge),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 20),
              const Text("Login", style: AppTextStyles.bodyLarge),
              TextFormField(
                controller: _loginController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: _validateLogin,
              ),
              const SizedBox(height: 16),
              const Text("Password", style: AppTextStyles.bodyLarge),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 16),
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
                                  content: Text("Registration is successful!"),
                                );
                              },
                            );
                          }
                        },
                        child: const Text("Sign up"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator .pop(context);
                  },
                  child: const Text("Back"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}