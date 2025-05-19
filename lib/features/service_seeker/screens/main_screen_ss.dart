import 'package:carely/features/service_seeker/widgets/bottom_nav_bar_ss.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    // HomeScreen(),
    // BookingsScreen(),
    // ChatScreen(),
    // ProfileScreen(),
    Center(child: Text('Home Screen')),
    Center(child: Text('Bookings Screen')),
    Center(child: Text('Chat Screen')),
    Center(child: Text('Profile Screen')),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBarSs(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}