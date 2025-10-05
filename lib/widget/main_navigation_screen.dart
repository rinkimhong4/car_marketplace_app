import 'package:flutter/material.dart';
import 'package:car_marketplace_app/modules/view/home_screen.dart';
import 'package:car_marketplace_app/modules/view/order_screen.dart';
import 'package:car_marketplace_app/modules/view/inbox_screen.dart';
import 'package:car_marketplace_app/modules/view/wallet_screen.dart';
import 'package:car_marketplace_app/modules/view/profile_screen.dart';
import 'package:car_marketplace_app/widget/custom_navigation_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const OrderScreen(),
    const InboxScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
