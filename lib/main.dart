import 'package:carely/firebase_options.dart';
import 'package:carely/providers/booking_provider.dart';
import 'package:carely/providers/caregiver_profile_provider.dart';
import 'package:carely/providers/caregivers_list_provider.dart';
import 'package:carely/providers/seeker_profile_provider.dart';
import 'package:carely/routes/app_routes.dart';
import 'package:carely/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SeekerProfileProvider()),
        ChangeNotifierProvider(create: (_) => CaregiverProfileProvider()),
        ChangeNotifierProvider(create: (_) => CaregiversListProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: MaterialApp(
        title: 'Carely',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: '/', // '/seeker/main',
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
