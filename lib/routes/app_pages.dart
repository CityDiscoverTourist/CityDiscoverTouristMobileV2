import 'package:travel_hour/pages/profile.dart';

import '../bindings/home_binding.dart';
import '../bindings/login_binding.dart';
import '../pages/home.dart';
import '../pages/sign_in.dart';
import '../pages/splash.dart';
import 'app_routes.dart';
import 'package:get/get.dart';
// ignore_for_file: prefer_const_constructors

class AppPages {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: KWelcomeScreen, page: () => HomePage(), binding: HomeBinding()),
      GetPage(
          name: KLoginScreen, page: () => SignInPage(), binding: HomeBinding()),
      GetPage(
          name: KProfileScreen,
          page: () => ProfilePage(),
          binding: HomeBinding()),
      GetPage(
          name: KSplashScreen,
          page: () => SplashPage(),
          binding: HomeBinding()),
    ];
  }
}
