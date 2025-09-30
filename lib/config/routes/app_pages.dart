import 'package:car_marketplace_app/config/routes/app_routes.dart';
import 'package:car_marketplace_app/modules/view/auth/signin/sing_in_screen.dart';
import 'package:car_marketplace_app/modules/view/auth/signup/sign_up_screen.dart';
import 'package:car_marketplace_app/modules/view/home_screen.dart';
import 'package:car_marketplace_app/modules/view/splash/on_boarding_screen.dart';
import 'package:car_marketplace_app/modules/view/splash/splash_screen.dart';
import 'package:car_marketplace_app/modules/view/user_fill_profile_screen.dart';
import 'package:get/get.dart';

class AppRouting {
  static final route = RouteView.values.map((e) {
    switch (e) {
      case RouteView.home:
        return GetPage(
          name: "/",
          page: () => const HomeScreen(),
          transition: Transition.noTransition,
        );
      case RouteView.splash:
        return GetPage(
          name: "/${e.name}",
          page: () => const SplashScreen(),
          // binding: NotificationBinding(),
        );
      case RouteView.onboarding:
        return GetPage(
          name: "/${e.name}",
          page: () => const OnBoardingScreen(),
          // binding: NotificationBinding(),
        );
      case RouteView.signin:
        return GetPage(
          name: "/${e.name}",
          page: () => const SingInScreen(),
          // binding: NotificationBinding(),
        );
      case RouteView.signup:
        return GetPage(
          name: "/${e.name}",
          page: () => const SignUpScreen(),
          // binding: NotificationBinding(),
        );
      case RouteView.userfillprofile:
        return GetPage(
          name: "/${e.name}",
          page: () => const UserFillProfileScreen(),
          // binding: NotificationBinding(),
        );
    }
  }).toList();
}
