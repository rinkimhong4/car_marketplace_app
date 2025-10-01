import 'package:car_marketplace_app/config/routes/app_routes.dart';
import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:car_marketplace_app/widget/app_bar_widget.dart';
import 'package:car_marketplace_app/widget/app_logo.dart';
import 'package:car_marketplace_app/widget/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingInScreen extends StatelessWidget {
  const SingInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildBodyContent()),
        ],
      ),
    );
  }

  /// --- AppBar Block ---
  Widget _buildAppBar() {
    return const AppBarBack(
      backgroundColor: AppColors.white,
    );
  }

  /// --- Body Content Block ---
  Widget _buildBodyContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 62),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogo(size: 180),
          const SizedBox(height: 14),
          const Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Sign in with your email and password \nor continue with social media",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 30),
          _buildSocailBotton(),
          const SizedBox(height: 30),
          _buildRowRuler,
          const SizedBox(height: 32),
          PrimaryButtonApp(
            text: "Sign In",
            backgroundColor: Colors.black,
            onPressed: () {
              RouteView.userfillprofile.go();
            },
          ),
          const SizedBox(height: 16),

          // Sign Up Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  RouteView.signup.go();
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  get _buildRowRuler {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 0.5,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withValues(alpha: 0.4),
          ),
        ),
        Text(
          'Or',
          style: AppTextStyle.regular12(color: Colors.black),
        ),
        Container(
          height: 0.5,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }

  Widget _buildSocailBotton() {
    return const Column(children: [SocialButtonList()]);
  }
}

/// --- List of Social Buttons ---
class SocialButtonList extends StatelessWidget {
  final double spacing;
  final double iconSize;
  final double buttonHeight;
  final bool showTitle;
  final double horizontalPadding;

  /// If showTitle is false, you can display icons in a Row instead of Column
  final bool useRowWhenNoTitle;

  const SocialButtonList({
    this.spacing = 6,
    this.iconSize = 24,
    this.buttonHeight = 52,
    this.showTitle = true,
    this.horizontalPadding = 16,
    this.useRowWhenNoTitle = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> social = [
      {"icon": CupertinoIcons.mail_solid, "title": "Continue with Google"},
      {"icon": Icons.facebook, "title": "Continue with Facebook"},
      {"icon": Icons.apple, "title": "Continue with Apple"},
    ];

    if (!showTitle && useRowWhenNoTitle) {
      // show icons in a Row
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: social.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: SocialButton(
              icon: item['icon'],
              title: item['title'],
              iconSize: iconSize,
              height: iconSize + 38,
              showTitle: false,
              horizontalPadding: 8,
              verticalPadding: 18,
              onPressed: () {
                //handle social login
              },
            ),
          );
        }).toList(),
      );
    }

    // default Column
    return Column(
      spacing: 10,
      children: List.generate(
        social.length,
        (index) => Padding(
          padding:
              EdgeInsets.only(bottom: index == social.length - 1 ? 0 : spacing),
          child: SocialButton(
            icon: social[index]['icon'],
            title: social[index]['title'],
            iconSize: iconSize,
            height: showTitle ? buttonHeight : iconSize + 16,
            showTitle: showTitle,
            horizontalPadding: showTitle ? horizontalPadding : 8,
            onPressed: () {
              //  Handle social login
            },
          ),
        ),
      ),
    );
  }
}

/// --- Single Social Button Widget ---
class SocialButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final double iconSize;
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final Color backgroundColor;
  final bool showTitle;
  final VoidCallback onPressed;

  const SocialButton({
    required this.icon,
    required this.title,
    required this.onPressed,
    this.height = 52,
    this.iconSize = 24,
    this.horizontalPadding = 16,
    this.verticalPadding = 8,
    this.backgroundColor = Colors.white,
    this.showTitle = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: showTitle ? double.infinity : iconSize + verticalPadding * 2,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: Colors.black.withValues(alpha: 0.3), width: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment:
              showTitle ? MainAxisAlignment.center : MainAxisAlignment.center,
          mainAxisSize: showTitle ? MainAxisSize.max : MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.black, size: iconSize),
            if (showTitle) ...[
              const SizedBox(width: 12),
              Text(
                title,
                style: AppTextStyle.bold16(color: Colors.black),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
