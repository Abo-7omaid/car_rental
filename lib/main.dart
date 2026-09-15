import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/route/app_routes.dart';
import 'core/constants/app_theme.dart';
import 'features/splash/screens/splash_screen.dart';

Future<void> main() async {
  // This line is REQUIRED before any async work (Supabase, Hive, SharedPrefs).
  // Without it, Flutter's engine isn't ready and async calls can crash.
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://neizzshqtuaigwhgotpk.supabase.co',
    anonKey: 'sb_publishable_YszQKMv7sR4qqt6_3RJYmg_D2usm4qZ',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RentRide',
      debugShowCheckedModeBanner: false,

      // These two lines activate your AppTheme (light + dark mode support)
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark, // follows the phone's dark/light setting
      // themeMode: ThemeMode.light, // follows the phone's dark/light setting

      // This is the FIRST screen the user sees
      home: const SplashScreen(),

      // THIS IS THE KEY FIX: register all your named routes here.
      // Without this, Navigator.pushReplacementNamed(context, '/intro')
      // throws "Could not find a generator for route" and the app freezes.
      routes: AppRoutes.routes,
    );
  }
}