import 'dart:async';
import 'package:flutter/material.dart';
import 'auth/AuthWelcomeScreen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() =>
      _LoadingScreenState();
}

class _LoadingScreenState
    extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const AuthWelcomeScreen(),
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        239,
        255,
        255,
        255,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Image.asset(
              'imgs/logoMobile.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            Text( 
              'Quản Lý Chi Tiêu',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(
              color: const Color.fromARGB(
                255,
                27,
                215,
                240,
              ),
              strokeAlign: 3,
            ),
            SizedBox(height: 12),
            Text(
              'Đang tải...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
