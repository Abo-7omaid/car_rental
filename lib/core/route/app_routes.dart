import 'package:car_rental/features/favorite/screens/favorite_screen.dart';
import 'package:flutter/material.dart';
import '../../features/auth/screens/forget_password.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/splash/screens/Intro_Screen.dart';
import '../../features/auth/screens/login.dart';
import '../../features/auth/screens/register.dart';
import '../../features/home/screens/home.dart';
import '../../features/booking/screens/booking.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String intro = '/intro';
  static const String login = '/login';
  static const String forgetPassword = '/forgetPassword';
  static const String profile = '/profile';
  static const String register = '/register';
  static const String home = '/home';
  static const String bookings = '/bookings';
  static const String favorites = '/favorites';

  static Map<String, WidgetBuilder> routes = {




    splash: (context) => const SplashScreen(),
    intro: (context) => const IntroScreen(),
    login: (context) => const LoginScreen(),
    profile: (context) => const ProfileScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) => const HomeScreen(),
    bookings: (context) => const BookingsScreen(),
    favorites: (context) => const FavoriteScreen(),
    forgetPassword: (context) => const ForgotPasswordScreen(),

  };





}