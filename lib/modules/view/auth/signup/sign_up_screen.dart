import 'package:car_marketplace_app/config/routes/app_routes.dart';
import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:car_marketplace_app/modules/view/auth/signin/sing_in_screen.dart';
import 'package:car_marketplace_app/widget/app_bar_widget.dart';
import 'package:car_marketplace_app/widget/app_logo.dart';
import 'package:car_marketplace_app/widget/auth_text_field.dart';
import 'package:car_marketplace_app/widget/primary_button.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(child: _buildBodyContent()),
          ],
        ),
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
        children: [
          const AppLogo(size: 180),
          const SizedBox(height: 14),
          const Text(
            "Create Your Account",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              RoundedTextField(
                controller: emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              PasswordInput(
                controller: passwordController,
                hintText: "Password",
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
            ],
          ),
          const SizedBox(height: 10),
          RememberMe(
            value: rememberMe,
            onChanged: (val) => setState(() => rememberMe = val),
          ),
          const SizedBox(height: 30),
          PrimaryButtonApp(
            text: "Sign Up",
            backgroundColor: Colors.black,
            onPressed: () {},
          ),
          const SizedBox(height: 30),
          const RowRuler(),
          const SizedBox(height: 30),
          const SocialButtonList(
            iconSize: 28,
            showTitle: false,
            useRowWhenNoTitle: true,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  RouteView.signin.go();
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// --- Custom Remember Me Widget ---
class RememberMe extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const RememberMe({required this.value, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            value
                ? Icons.check_box_rounded
                : Icons.check_box_outline_blank_rounded,
            color: Colors.black,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            "Remember me",
            style: AppTextStyle.regular12(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

/// --- Custom Row Ruler Widget ---
class RowRuler extends StatelessWidget {
  const RowRuler({super.key});

  @override
  Widget build(BuildContext context) {
    final dividerColor = Colors.black.withValues(alpha: 0.4);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 0.5,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: dividerColor,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Or continue with',
          style: AppTextStyle.regular12(color: Colors.black),
        ),
        const SizedBox(width: 10),
        Container(
          height: 0.5,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: dividerColor,
          ),
        ),
      ],
    );
  }
}
