
import '../bindings/home_binding.dart';
import '../pages/home.dart';
import 'app_routes.dart';
import 'package:get/get.dart';
// ignore_for_file: prefer_const_constructors

class AppPages {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: KWelcomeScreen,
          page: () => HomePage(),
          binding: HomeBinding()),
      // GetPage(
      //     name: KLoginScreen,
      //     page: () => LoginScreen(),
      //     binding: LoginBinding()
      //     ),
    ];
  }
}
