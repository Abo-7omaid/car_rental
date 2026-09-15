import 'package:flutter/material.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/splash/screens/Intro_Screen.dart';
import '../../features/auth/screens/login.dart';
import '../../features/auth/screens/register.dart';
import '../../features/home/screens/home.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String intro = '/intro';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    intro: (context) => const IntroScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) => const HomeScreen(),
  };





}