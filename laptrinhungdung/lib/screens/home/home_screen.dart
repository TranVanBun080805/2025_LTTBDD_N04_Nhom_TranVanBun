import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import 'dashboard_screen.dart';
import 'statistic_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';
import 'addCategoryScreen.dart';

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
    HistoryScreen(),
    SettingScreen(),
  ];

  void handleAdd() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddCategoryScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navbar(
      body: AnimatedSwitcher(
        duration: const Duration(
          milliseconds: 300,
        ),
        child: pages[currentIndex],
      ),
      currentIndex: currentIndex,
      onTabSelected: (index) =>
          setState(() => currentIndex = index),
      onAddPressed: handleAdd,
    );
  }
}
