import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import 'dashboard_screen.dart';
import 'statistic_screen.dart';
import 'profile_screen.dart';
import 'setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    DashboardScreen(),
    StatisticScreen(),
    ProfileScreen(),
    SettingScreen(),
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
        duration: Duration(seconds: 2),
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
