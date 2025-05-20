import 'package:carely/features/care_giver/screens/home_screen_cg.dart';
import 'package:carely/features/care_giver/screens/profile_screen_cg.dart';
import 'package:carely/features/care_giver/screens/schedule_details_screen_cg.dart';
import 'package:carely/features/common/login_screen_cg.dart';
import 'package:carely/features/care_giver/screens/main_screen_ss.dart';
import 'package:carely/features/care_giver/screens/registration_cg.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> caregiverRoutes = {
  '/caregiver/main': (context) => const MainScreenCg(),
  '/caregiver/register': (context) => CaregiverRegistrationScreen(),

  '/caregiver/home': (context) =>  HomeScreenCg(),
  '/caregiver/profile': (context) => ProfileScreenCg(),
  '/caregiver/bookingDetails': (context) => ScheduleDetailsScreenCg(),
};
