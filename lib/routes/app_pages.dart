import 'package:travel_hour/pages/completed_questV2.dart';
import 'package:travel_hour/pages/history.dart';
import 'package:travel_hour/pages/quest_play.dart';
import 'package:travel_hour/pages/sign_inV2.dart';
import 'package:travel_hour/pages/profile.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/pages/test/map.dart';

import '../bindings/home_binding.dart';
import '../bindings/login_binding.dart';
import '../pages/home.dart';
import '../pages/momo_payment.dart';
import '../pages/sign_in.dart';
import '../pages/splash.dart';
import '../pages/test.dart';
import 'app_routes.dart';
import 'package:get/get.dart';
// ignore_for_file: prefer_const_constructors

class AppPages {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: KWelcomeScreen, page: () => HomePage(),
          //  binding: HomeBinding()
           ),
      GetPage(
          name: KLoginScreen,
          page: () => LoginScreen(),
          // binding: LoginBinding()
          ),
      GetPage(
          name: KProfileScreen,
          page: () => ProfilePage(),
          // binding: HomeBinding()
          ),
      GetPage(
          name: KSplashScreen,
          page: () => SplashStart(),
          // binding: HomeBinding()
          ),
      GetPage(
          name: KHistoryScreen,
          page: () => HistoryPage(),
          // binding: HomeBinding()
          ),
      GetPage(
          name: KMapScreen,
          page: () => ManyMarkersPage(),
          // binding: HomeBinding()
          ),
      GetPage(
          name: KMomoPaymentScreen,
          page: () => MomoPaymentPage(),
          // binding: HomeBinding()
          ),
          GetPage(
          name: KCompletedPage,
          page: () => CompletedPageV2(),
          // binding: HomeBinding()
          ),
               GetPage(
          name: '/TEST',
          page: () => AnswerPageV3(),
          // binding: HomeBinding()
          ),
    ];
  }
}
