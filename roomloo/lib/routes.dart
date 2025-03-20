import 'package:flutter/material.dart';
import 'package:roomloo/screens/email_reset_screen.dart';
import 'package:roomloo/screens/home_screen.dart';
import 'package:roomloo/screens/reset_sms_screen.dart';
import 'package:roomloo/screens/signin_screen.dart';
import 'package:roomloo/screens/signup_screen.dart';
import 'package:roomloo/screens/welcome_screen.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String home = '/home';
  static const String emailReset = '/email-reset';
  static const String resetSms = '/reset-sms';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case emailReset:
        return MaterialPageRoute(builder: (_) => const ResetEmailScreen());
      case resetSms:
        return MaterialPageRoute(builder: (_) => const ResetSmsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Page Not Found")),
          ),
        );
    }
  }
}
