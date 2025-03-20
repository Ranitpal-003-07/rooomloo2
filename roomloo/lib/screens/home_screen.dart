import 'package:flutter/material.dart';
import 'package:roomloo/screens/find_pg_screen.dart';
import 'package:roomloo/screens/find_roommate_screen.dart';
import 'package:roomloo/screens/post_update_screen.dart';
import 'package:roomloo/screens/chat_screen.dart';
import 'package:roomloo/screens/profile_screen.dart';
import 'package:roomloo/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    FindPGScreen(),
    FindRoommateScreen(),
    PostUpdateScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Roomloo"),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Find PG"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Find Roommate"),
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: "Post Update"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreen()),
          );
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
