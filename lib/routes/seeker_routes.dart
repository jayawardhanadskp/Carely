import 'package:carely/features/service_seeker/screens/book_caregiver_screen_ss.dart';
import 'package:carely/features/service_seeker/screens/booking_details_screen_ss.dart';
import 'package:carely/features/service_seeker/screens/bookings_screen_ss.dart';
import 'package:carely/features/service_seeker/screens/caregiver_profile_view_ss.dart';
import 'package:carely/features/service_seeker/screens/home_screen_ss.dart';
import 'package:carely/features/service_seeker/screens/main_screen_ss.dart';
import 'package:carely/features/service_seeker/screens/registration_ss.dart';
import 'package:flutter/material.dart';


final Map<String, WidgetBuilder> seekerRoutes = {
  '/seeker/main': (context) => MainScreenSs(),
  '/seeker/register': (context) => RegistrationSs(),
  '/seeker/home': (context) => HomeScreenSs(),
  '/seeker/bookings': (context) => BookingsScreenSs(),
  '/seeker/bookingDetails': (context) => BookingDetailsScreenSs(),
  '/seeker/caregiverProView': (context) => CaregiverProfileViewSs(),
  '/seeker/bookingCaregiver': (context) => BookCaregiverScreenSs(),
};
