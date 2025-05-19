import 'package:carely/firebase_options.dart';
import 'package:carely/routes/app_routes.dart';
import 'package:carely/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carely',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
       initialRoute: '/caregiver/register', // '/seeker/main',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

