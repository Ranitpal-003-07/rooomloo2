import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roomloo/firebase_options.dart';
import 'package:roomloo/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferences.getInstance(); // Ensures shared preferences is initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roomloo',
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? AppRoutes.welcome // If no user, show welcome screen
          : AppRoutes.home, // If logged in, go to home screen
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
