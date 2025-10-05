import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      unselectedFontSize: 12,
      unselectedLabelStyle: AppTextStyle.regular12(color: Colors.black54),
      selectedLabelStyle: AppTextStyle.regular12(),
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/home.png',
            width: 24,
            height: 24,
            color: currentIndex == 0 ? Colors.black : Colors.black54,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/shopping-cart.png',
            width: 24,
            height: 24,
            color: currentIndex == 1 ? Colors.black : Colors.black54,
          ),
          label: 'Order',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/inbox.png',
            width: 24,
            height: 24,
            color: currentIndex == 2 ? Colors.black : Colors.black54,
          ),
          label: 'Inbox',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/wallet.png',
            width: 24,
            height: 24,
            color: currentIndex == 3 ? Colors.black : Colors.black54,
          ),
          label: 'Wallet',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/profile.png',
            width: 24,
            height: 24,
            color: currentIndex == 4 ? Colors.black : Colors.black54,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
