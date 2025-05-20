import 'package:carely/routes/caregiver_routes.dart';
import 'package:flutter/material.dart';
import 'seeker_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Combine seeker + provider routes
    final allRoutes = {
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
        builder: (_) => const Scaffold(
          body: Center(child: Text('Page not found')),
        ),
      );
    }
  }
}
