import 'package:flutter/material.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trang quản lý chi tiêu',
        ),
        backgroundColor: const Color(0xFF1E2A78),
      ),
      body: const Center(
        child: Text(
          'Chào mừng bạn đến với ứng dụng quản lý chi tiêu!',

          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
