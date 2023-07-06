import 'package:demo/FailureReportPages/success_page.dart';
import 'package:flutter/material.dart';

import '../navbars/bottom_navbar.dart';

class Notifications extends StatefulWidget {

  const Notifications();
  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  NotificationsState();
  int _currentIndex = 1;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      // Navigate to Home Page
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      // Navigate to Search Page
      Navigator.pushReplacementNamed(context, '/notifications');
    } else if (index == 2) {
      // Navigate to Settings Page
      Navigator.pushReplacementNamed(context, '/failures_list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Container(
      ),  bottomNavigationBar: BottomNavBarWidget(
      currentIndex: _currentIndex,
      onTabTapped: _onTabTapped,
    )
    );

  }
// Implement the state and build method for the form page here
// ...
}