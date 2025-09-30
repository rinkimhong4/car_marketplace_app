import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, this.size = 90});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo/app-logo.png',
      width: size,
      height: size,
    );
  }
}
