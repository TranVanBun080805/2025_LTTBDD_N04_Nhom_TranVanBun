import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'utils/colors.dart';
import 'screens/auth/AuthWelcomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Part-time Job App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryColor,
        ),
        useMaterial3: true,
      ),
      home: const AuthWelcomeScreen(),
    );
  }
}
