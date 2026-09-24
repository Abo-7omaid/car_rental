import 'package:car_rental/features/booking/screens/booking.dart';
import 'package:car_rental/features/home/screens/home.dart';
import 'package:car_rental/intro.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'data/services/notification_service.dart';
import 'data/services/permission_service.dart';

import 'core/route/app_routes.dart';
import 'core/constants/app_theme.dart';
import 'features/splash/screens/splash_screen.dart';
import 'features/auth/screens/login.dart';

Future<void> main() async {
  // This line is REQUIRED before any async work (Supabase, Hive, SharedPrefs).
  // Without it, Flutter's engine isn't ready and async calls can crash.
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://neizzshqtuaigwhgotpk.supabase.co',
    anonKey: 'sb_publishable_YszQKMv7sR4qqt6_3RJYmg_D2usm4qZ',
  );

  await PermissionService.requestLocationPermission();

  await NotificationService.init();




  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RentRide',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      // themeMode: ThemeMode.dark, // follows the phone's dark/light setting
      themeMode: ThemeMode.system,

      home: SplashScreen(),
      // home: HomeScreen(),






      routes: AppRoutes.routes,
    );
  }
}