import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  BottomNavBarWidget({required this.currentIndex, required this.onTabTapped});

  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Failure List',
        ),
      ],
    );
  }
}