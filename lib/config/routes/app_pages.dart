import 'package:car_marketplace_app/config/routes/app_routes.dart';
import 'package:car_marketplace_app/core/models/product_detail_model.dart';
import 'package:car_marketplace_app/modules/items/notification_screen.dart';
import 'package:car_marketplace_app/modules/items/rating_and_reviews.dart';
import 'package:car_marketplace_app/modules/items/special_offers_screen.dart';
import 'package:car_marketplace_app/modules/items/top_deals_screen.dart';
import 'package:car_marketplace_app/modules/items/wish_list_screen.dart';
import 'package:car_marketplace_app/modules/view/auth/signin/sing_in_screen.dart';
import 'package:car_marketplace_app/modules/view/auth/signup/sign_up_screen.dart';
import 'package:car_marketplace_app/modules/view/car_detail_screen.dart';
import 'package:car_marketplace_app/modules/view/forgotpassword/forgot_password_screen.dart';
import 'package:car_marketplace_app/widget/main_navigation_screen.dart';
import 'package:car_marketplace_app/modules/view/splash/on_boarding_screen.dart';
import 'package:car_marketplace_app/modules/view/splash/splash_screen.dart';
import 'package:car_marketplace_app/widget/user_fill_profile_screen.dart';
import 'package:car_marketplace_app/widget/otp_screen_widget.dart';
import 'package:get/get.dart';

class AppRouting {
  static final route = RouteView.values.map((e) {
    switch (e) {
      case RouteView.home:
        return GetPage(
          name: "/",
          page: () => const MainNavigationScreen(),
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
      case RouteView.otp:
        return GetPage(
          name: "/${e.name}",
          page: () => const OtpScreenWidget(),
          // binding: NotificationBinding(),
        );
      case RouteView.forgotpassword:
        return GetPage(
          name: "/${e.name}",
          page: () => const ForgotPasswordScreen(),
          // binding: NotificationBinding(),
        );
      case RouteView.createnewpassword:
        return GetPage(
          name: "/${e.name}",
          page: () => const CreateNewPassword(),
          // binding: NotificationBinding(),
        );
      case RouteView.carDetail:
        return GetPage(
          name: "/${e.name}",
          page: () => CarDetailScreen(product: Get.arguments as ProductDetail),
          // binding: NotificationBinding(),
        );
      case RouteView.reivews:
        return GetPage(
          name: "/${e.name}",
          page: () => const RatingAndReviews(),
          // binding: NotificationBinding(),
        );
      case RouteView.notification:
        return GetPage(
          name: "/${e.name}",
          page: () => const NotificationScreen(),
          // binding: NotificationBinding(),
        );
      case RouteView.specialOffers:
        return GetPage(
          name: "/${e.name}",
          page: () => const SpecialOffersScreen(),
          // binding: NotificationBinding(),
        );
      case RouteView.wishList:
        return GetPage(
          name: "/${e.name}",
          page: () => const WishListScreen(),
          // binding: NotificationBinding(),
        );
      case RouteView.topDeals:
        return GetPage(
          name: "/${e.name}",
          page: () => const TopDealsScreen(),
          // binding: NotificationBinding(),
        );
    }
  }).toList();
}
