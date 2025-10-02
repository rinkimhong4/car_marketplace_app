import 'package:car_marketplace_app/config/routes/app_routes.dart';
import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:car_marketplace_app/modules/view/auth/signup/sign_up_screen.dart';
import 'package:car_marketplace_app/widget/app_bar_widget.dart';
import 'package:car_marketplace_app/widget/auth_text_field.dart';
import 'package:car_marketplace_app/widget/otp_screen_widget.dart';
import 'package:car_marketplace_app/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int? selectedIndex;
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
      title: "Forgot Password",
      // backgroundColor: AppColors.white,
    );
  }

  /// --- Body Content Block ---
  Widget _buildBodyContent() {
    return Column(
      children: [
        Lottie.asset(
          'assets/loading/robotf.json',
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 120.0),
          child: Text(
            'Select which contact details should \nwe use to reset your passrowd ',
            style: AppTextStyle.regular14(color: Colors.black),
          ),
        ),
        _buildOptoinSelect
      ],
    );
  }

  get _buildOptoinSelect {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18, top: 30),
      child: Column(children: [
        _buildOption(
          index: 0,
          icon: Icons.chat_rounded,
          title: "via SMS",
          subtitle: "+855 *****135",
        ),
        _buildOption(
          index: 1,
          icon: Icons.email_rounded,
          title: "via Email",
          subtitle: "example***@mail.com",
        ),
        PrimaryButtonApp(
            text: "Continue",
            backgroundColor: Colors.black,
            onPressed: () {
              Get.to(() => const OtpScreenWidgetTest());
            }),
      ]),
    );
  }

  Widget _buildOption({
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black12 : Colors.white,
          border: Border.all(
            width: 1.5,
            color: isSelected ? Colors.black : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.black : Colors.black87,
                    size: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.regular12(
                    color: Colors.black54,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTextStyle.regular16(
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OtpScreenWidgetTest extends StatelessWidget {
  const OtpScreenWidgetTest({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      "OTP Verification",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "We sent your code to +855 898 860 *** \nThis code will expired in 00:30",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    // const SizedBox(height: 16),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    const OtpForm(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Resend OTP Code",
                        style: TextStyle(color: Color(0xFF757575)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 64,
                width: 64,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide: const BorderSide(color: Colors.black))),
                ),
              ),
              SizedBox(
                height: 64,
                width: 64,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide: const BorderSide(color: Colors.black))),
                ),
              ),
              SizedBox(
                height: 64,
                width: 64,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide: const BorderSide(color: Colors.black))),
                ),
              ),
              SizedBox(
                height: 64,
                width: 64,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide: const BorderSide(color: Colors.black))),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          PrimaryButtonApp(
            backgroundColor: Colors.black,
            text: 'Verify',
            onPressed: () {
              ModernAutoDialog.show(
                context: context,
                lottieAsset: 'assets/loading/loaing.json',
                title: "OTP Verified",
                message: "Your OTP has been successfully verified.",
                onDismiss: () {
                  RouteView.createnewpassword.go();
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildTextFormField(context)),
        ],
      ),
    );
  }

  /// --- AppBar Block ---
  Widget _buildAppBar() {
    return const AppBarBack(
      title: "Forgot Password",
      // backgroundColor: AppColors.white,
    );
  }

  Widget _buildTextFormField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        spacing: 10,
        children: [
          const RoundedTextField(
            hintText: 'New Password',
          ),
          const RoundedTextField(
            hintText: 'Conform Password',
          ),
          RememberMe(
            value: rememberMe,
            onChanged: (val) => setState(() => rememberMe = val),
          ),
          PrimaryButtonApp(
            backgroundColor: Colors.black,
            text: 'Continue',
            onPressed: () {
              ModernAutoDialog.show(
                context: context,
                lottieAsset: 'assets/loading/loaing.json',
                title: "OTP Verified",
                message: "Your OTP has been successfully verified.",
                onDismiss: () {
                  RouteView.home.go(clearAll: true);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
