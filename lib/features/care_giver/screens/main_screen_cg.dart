import 'package:carely/features/care_giver/screens/bookings_screen_cg.dart';
import 'package:carely/features/care_giver/screens/home_screen_cg.dart';
import 'package:carely/features/care_giver/screens/profile_screen_cg.dart';
import 'package:carely/features/care_giver/widgets/bottom_nav_bar_cg.dart';
import 'package:carely/features/common/chat_list_screen.dart';

import 'package:carely/features/service_seeker/widgets/bottom_nav_bar_ss.dart';
import 'package:flutter/material.dart';

class MainScreenCg extends StatefulWidget {
  const MainScreenCg({super.key});

  @override
  MainScreenCgState createState() => MainScreenCgState();
}

class MainScreenCgState extends State<MainScreenCg> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _screens = [
    HomeScreenCg(onTabSelected: _onTabTapped,),

    BookingsScreenCg(),
    ChatListScreen(),
    ProfileScreenCg(),
  ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBarCg(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
