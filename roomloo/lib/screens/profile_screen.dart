import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roomloo/screens/edit_profile_screen.dart';
import 'package:roomloo/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:roomloo/screens/signin_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? user;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    if (user != null) {
      _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    DocumentSnapshot userDoc = await _db.collection('users').doc(user!.uid).get();
    if (userDoc.exists) {
      setState(() {
        userData = userDoc.data() as Map<String, dynamic>?;
      });
    }
  }

  void _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, size: 50, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    userData!["name"],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(userData!["email"], style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text("Phone: ${userData!["phone"]}", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfileScreen()),
                      );
                    },
                    child: const Text("Edit Profile"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _logout(context),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Logout", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
    );
  }
}
