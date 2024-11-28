import 'package:flutter/material.dart';
import './widgets/sign_in_screen.dart';
import 'config/theme_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication App',
      theme: AppTheme.getTheme(),
      home: SignInScreen(),
    );
  }
}