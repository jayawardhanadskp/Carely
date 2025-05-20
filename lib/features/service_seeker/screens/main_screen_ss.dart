import 'package:carely/features/service_seeker/screens/all_caregivers_ss.dart';
import 'package:carely/features/service_seeker/screens/bookings_screen_ss.dart';
import 'package:carely/features/service_seeker/screens/home_screen_ss.dart';
import 'package:carely/features/service_seeker/screens/profile_scree_ss.dart';
import 'package:carely/features/service_seeker/widgets/bottom_nav_bar_ss.dart';
import 'package:flutter/material.dart';

class MainScreenSs extends StatefulWidget {
  const MainScreenSs({super.key});

  @override
  MainScreenSsState createState() => MainScreenSsState();
}

class MainScreenSsState extends State<MainScreenSs> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreenSs(),
    BookingsScreenSs(),
    AllCaregiversListScreenSs(),
    ProfileScreen(),
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
