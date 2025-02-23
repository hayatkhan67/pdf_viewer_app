import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

import 'doc_screem.dart';
import 'home_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedIndex = 0;

  void setIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<IconData> navIcon = [
    Icons.home,
    Icons.filter_list_sharp,
  ];

  List<String> navLabel = [
    'Home',
    'All Docs',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          HomeScreen(),
          AllDocsScreen(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.white,
        height: 70,
        color: Colors.red,
        index: selectedIndex,
        animationDuration: const Duration(milliseconds: 400),
        items: List.generate(
          navIcon.length,
          (index) => CurvedNavigationBarItem(
            child: Icon(
              navIcon[index],
              size: 30,
              color: selectedIndex == index ? Colors.red : Colors.white,
            ),
          ),
        ),
        onTap: setIndex,
      ),
    );
  }
}
