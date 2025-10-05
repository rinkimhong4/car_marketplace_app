import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_marketplace_app/config/routes/app_routes.dart';
import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:car_marketplace_app/widget/app_bar_widget.dart';
import 'package:car_marketplace_app/widget/auth_text_field.dart';
import 'package:car_marketplace_app/widget/date_field_widget.dart';
import 'package:car_marketplace_app/widget/phone_input_widget.dart';
import 'package:car_marketplace_app/widget/primary_button.dart';
import 'package:flutter/material.dart';

class UserFillProfileScreen extends StatefulWidget {
  const UserFillProfileScreen({super.key});

  @override
  State<UserFillProfileScreen> createState() => _UserFillProfileScreenState();
}

class _UserFillProfileScreenState extends State<UserFillProfileScreen> {
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
      title: 'Fill Your Profile',
      // backgroundColor: AppColors.white,
    );
  }

  /// --- Body Content Block ---
  Widget _buildBodyContent() {
    return Column(
      children: [_buildCircleAvatar],
    );
  }

  /// --- Profile Picture Block ---
  Widget get _buildCircleAvatar {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18),
      child: Column(
        spacing: 20,
        children: [
          // Circle Avatar
          SizedBox(
            height: 130,
            width: 130,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                const CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    "https://img.freepik.com/free-photo/front-view-business-woman-suit_23-2148603018.jpg?semt=ais_hybrid&w=740&q=80",
                  ),
                ),
                Positioned(
                  right: -10,
                  bottom: 0,
                  child: SizedBox(
                    height: 44,
                    width: 44,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(color: Colors.white),
                        ),
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        //  Handle change profile picture
                      },
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Text Form Fields
          const SizedBox(
            height: 10,
          ),
          const RoundedTextField(
            backgroundColor: AppColors.background,
            hintText: 'Full Name',
          ),
          const RoundedTextField(
            backgroundColor: AppColors.background,
            hintText: 'Nikename',
          ),
          const DateField(),
          const RoundedTextField(
            backgroundColor: AppColors.background,
            hintText: 'Nikename',
          ),
          const PhoneInputWidget(),
          const SizedBox(
            height: 5,
          ),
          PrimaryButtonApp(
            backgroundColor: Colors.black,
            text: 'Continue',
            onPressed: () {
              RouteView.otp.go();
            },
          )
        ],
      ),
    );
  }
}
