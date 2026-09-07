import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home/home_screen.dart';
import 'reels/reels_screen.dart';
import 'chat/chat_screen.dart';
import 'rewards/rewards_screen.dart';
import 'profile/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // 5 Main Tabs according to UI Architecture
  final List<Widget> _screens = const [
    HomeScreen(),
    ReelsScreen(),
    ChatScreen(),
    RewardsScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060709),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

