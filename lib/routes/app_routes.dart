import 'package:flutter/material.dart';
import '../features/authentication/login/view/login_screen.dart';
import '../features/authentication/signup/view/signup_screen.dart';
import '../features/home/view/home_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
    home: (context) => const HomeScreen(),
  };
}
