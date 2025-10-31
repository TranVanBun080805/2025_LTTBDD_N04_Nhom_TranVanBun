import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final int currentIndex;
  final Function(int) onTabSelected;
  final VoidCallback onAddPressed;

  const Navbar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.onAddPressed,
    required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ),
      appBar: appBar,
      body: body,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(
          255,
          221,
          221,
          221,
        ),
        shape: const CircleBorder(),
        onPressed: onAddPressed,
        elevation: 6,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation
              .centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(
          255,
          231,
          230,
          230,
        ),
        height: 70,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => onTabSelected(0),
              icon: Icon(
                Icons.home_outlined,
                color: currentIndex == 0
                    ? const Color(0xFF00B4D8)
                    : const Color.fromARGB(
                        179,
                        0,
                        0,
                        0,
                      ),
              ),
            ),
            IconButton(
              onPressed: () => onTabSelected(1),
              icon: Icon(
                Icons.bar_chart_outlined,
                color: currentIndex == 1
                    ? const Color(0xFF00B4D8)
                    : const Color.fromARGB(
                        179,
                        0,
                        0,
                        0,
                      ),
              ),
            ),
            const SizedBox(width: 40),
            IconButton(
              onPressed: () => onTabSelected(2),
              icon: Icon(
                Icons.receipt_long_outlined,
                color: currentIndex == 2
                    ? const Color(0xFF00B4D8)
                    : const Color.fromARGB(
                        179,
                        0,
                        0,
                        0,
                      ),
              ),
            ),
            IconButton(
              onPressed: () => onTabSelected(3),
              icon: Icon(
                Icons.account_circle_outlined,
                color: currentIndex == 3
                    ? const Color(0xFF00B4D8)
                    : const Color.fromARGB(
                        179,
                        0,
                        0,
                        0,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// End of navbar.dart