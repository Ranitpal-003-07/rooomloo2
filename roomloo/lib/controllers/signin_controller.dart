// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roomloo/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool rememberMe = false; // Add this line

  // Function to validate email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}");
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  // Function to validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  // Function to toggle remember me
  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
  }

   // Function to save email in SharedPreferences
  Future<void> loadEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      emailController.text = prefs.getString('saved_email') ?? '';
    } catch (e) {
      print("Error loading email: $e");
    }
  }

  Future<void> saveEmail(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('saved_email', email);
    } catch (e) {
      print("Error saving email: $e");
    }
  }

  // Function to handle sign-in
  Future<void> signIn(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;

    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Handle remember me logic (Save credentials to local storage if needed)
       if (rememberMe) {
        await saveEmail(emailController.text.trim());
      } else {
        await saveEmail("");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sign-in successful!"),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to home screen or dashboard after successful sign-in
    Navigator.pushReplacementNamed(context, AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Sign-in failed. Please try again.";

      if (e.code == 'user-not-found') {
        errorMessage = "No user found with this email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password. Please try again.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email format is invalid.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      isLoading = false;
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
