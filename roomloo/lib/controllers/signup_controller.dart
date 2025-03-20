// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupController {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth Instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  // Function to validate email format
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  // Function to validate phone number
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your phone number";
    }
    final phoneRegex = RegExp(r'^\d{10}$');
    if (!phoneRegex.hasMatch(value)) {
      return "Enter a valid 10-digit phone number";
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

  // Function to handle signup with Firebase Authentication
  Future<void> signup(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

       // Store additional user data in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      // If signup is successful
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Signup successful!"),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to login or home screen after successful signup
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Signup failed. Please try again.";

      if (e.code == 'email-already-in-use') {
        errorMessage = "This email is already registered. Try signing in.";
      } else if (e.code == 'weak-password') {
        errorMessage = "The password is too weak.";
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
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }
}
