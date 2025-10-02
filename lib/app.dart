import 'package:car_marketplace_app/config/routes/app_pages.dart';
import 'package:car_marketplace_app/config/routes/app_routes.dart';
import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // initialRoute: RouteView.splash.name,
      initialRoute: RouteView.home.name,
      getPages: AppRouting.route,
      // home: const OtpScreenWidget(),
    );
  }
}
