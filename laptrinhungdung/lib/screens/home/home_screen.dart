import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    Center(
      child: Text(
        'Trang chủ - Quản lý chi tiêu!',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Center(child: Text('Thống kê chi tiêu')),
    Center(child: Text('Trang cá nhân')),
    Center(child: Text('Cài đặt ứng dụng')),
  ];

  void handleAdd() {
    ScaffoldMessenger.of(
      context,
    ).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
          bottom: 20,
          left: 16,
          right: 16,
        ),
        content: const Text(
          "Thêm giao dịch mới!",
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navbar(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(
          255,
          191,
          195,
          214,
        ),
        title: const Text(
          'Trang quản lý chi tiêu',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: pages[currentIndex],
      currentIndex: currentIndex,
      onTabSelected: (index) =>
          setState(() => currentIndex = index),
      onAddPressed: handleAdd,
    );
  }
}
