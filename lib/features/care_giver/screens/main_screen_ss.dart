import 'package:carely/features/care_giver/screens/bookings_screen_cg.dart';
import 'package:carely/features/care_giver/screens/home_screen_cg.dart';
import 'package:carely/features/care_giver/screens/profile_screen_cg.dart';

import 'package:carely/features/service_seeker/widgets/bottom_nav_bar_ss.dart';
import 'package:flutter/material.dart';

class MainScreenCg extends StatefulWidget {
  const MainScreenCg({super.key});

  @override
  MainScreenCgState createState() => MainScreenCgState();
}

class MainScreenCgState extends State<MainScreenCg> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreenCg(),

    BookingsScreenCg(),
    Center(child: Text('Chat Screen')),
    ProfileScreenCg(),
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
