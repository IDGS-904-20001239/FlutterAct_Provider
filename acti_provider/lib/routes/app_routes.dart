import 'package:acti_provider/screens/checkSession_screen.dart';
import 'package:acti_provider/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../screens/screen_export.dart';
//Este no
class AppRoutes {
  static String initialRoute = '/Session';
  static Map<String, Widget Function(BuildContext context)> routes = {
    '/Home': (BuildContext context) => const HomeScreen(),
    '/Error': (BuildContext context) => const ErrorScreen(),
    '/Login': (BuildContext context) => const LoginScreen(),
    '/Session': (BuildContext context) => const CheckSessionScreen(),
  };
  static onGenerateRoute(settings) {
    return MaterialPageRoute(builder: (context) => const ErrorScreen());
  }
}
