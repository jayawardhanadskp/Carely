import 'package:carely/features/common/landing_screen.dart';
import 'package:carely/features/common/login_screen_cg.dart';
import 'package:carely/routes/caregiver_routes.dart';
import 'package:flutter/material.dart';
import 'seeker_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Combine seeker + provider routes
    final allRoutes = {
      '/': (context) => const LandingScreen(),
      '/login': (context) => LoginScreen(),
      ...seekerRoutes,
      ...caregiverRoutes,
    };

    final pageBuilder = allRoutes[settings.name];

    if (pageBuilder != null) {
      return MaterialPageRoute(
        builder: (context) => pageBuilder(context),
        settings: settings,
      );
    } else {
      return MaterialPageRoute(
        builder:
            (_) => const Scaffold(body: Center(child: Text('Page not found'))),
      );
    }
  }
}
