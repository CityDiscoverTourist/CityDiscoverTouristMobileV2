import 'dart:ui';

import 'package:travel_hour/bindings/quest_binding.dart';
import 'package:travel_hour/bindings/questdetail_binding.dart';
import 'package:travel_hour/config/colors.dart';
import 'package:travel_hour/pages/completed_questV2.dart';
import 'package:travel_hour/pages/history.dart';
import 'package:travel_hour/pages/more_quests.dart';
import 'package:travel_hour/pages/quest_detailV2.dart';
import 'package:travel_hour/pages/quest_play.dart';
import 'package:travel_hour/pages/sign_inV2.dart';
import 'package:travel_hour/pages/profile.dart';
import 'package:travel_hour/pages/splashV2.dart';
// import 'package:travel_hour/pages/test/map.dart';
import 'package:travel_hour/widgets/payment_widgetV2.dart';
import 'dart:math' as math;

import '../bindings/home_binding.dart';
import '../bindings/login_binding.dart';
import '../bindings/payment_binding.dart';
import '../bindings/purchased_binding.dart';
import '../pages/home.dart';
import '../pages/momo_payment.dart';
import '../pages/sign_in.dart';
// import '../pages/splash.dart';
import '../pages/test.dart';
import 'app_routes.dart';
import 'package:get/get.dart';
// ignore_for_file: prefer_const_constructors

class AppPages {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: KWelcomeScreen, page: () => HomePage(), binding: HomeBinding()),
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
          binding: LoginBinding()),
      GetPage(
        name: KHistoryScreen,
        page: () => HistoryPage(),
        // binding: HomeBinding()
      ),
      // GetPage(
      //     name: KMapScreen,
      //     page: () => ManyMarkersPage(),
      //     // binding: HomeBinding()
      //     ),
      // GetPage(
      //   name: KMomoPaymentScreen,
      //   page: () => MomoPaymentPage(),
      //   // binding: HomeBinding()
      // ),
      GetPage(
        name: KCompletedPage,
        page: () => CompletedPageV2(),
        // binding: HomeBinding()
      ),
      // GetPage(
      // name: KCompletedPage,
      // page: () => MomoPay(),
      // // binding: HomeBinding()
      // ),
      GetPage(
          name: KPlayingQuest,
          page: () => QuestsPlayPage(),
          binding: PurchasedBinding()),
      GetPage(
          name: KQuestDetailPage,
          page: () => QuestDetailsPageV2(),
          binding: QuestDetailBinding()),
           GetPage(
          name: KQuestByType,
          page: () => MoreQuestPage( color:AppColors.mainColor.withOpacity(1.0)),
          binding: QuestBinding()),
       GetPage(name: KPaymentMoMo, page: ()=>PaymentWidgetV2(),binding: PaymentBinding())
    ];
  }
}
