import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/history_controller.dart';
import 'package:travel_hour/controllers/questpurchased_controller.dart';
import 'package:travel_hour/controllers/voucher_controller.dart';
import 'package:travel_hour/pages/profile.dart';
import 'package:travel_hour/pages/quest_play.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/pages/voucher.dart';

import '../config/colors.dart';
import '../controllers/home_controller.dart';
import 'explore.dart';
import 'history.dart';

class HomePage extends GetView<HomeController> {
  HomeController controller = Get.put(HomeController());
 
  @override
  Widget build(BuildContext context) {
    var _currentIndex = controller.indexHomePage;
    final views = [
      Explore(),
      VoucherPage(),
      HistoryPage(),
      ProfilePage(),
    ];
    return Scaffold(
        body: Obx(() {
          if (controller.isLoading.value == true) {
            return SplashStart(
              content: 'waiting loading data...'.tr,
            );
          } else {
            if (_currentIndex.value == 1) {
              Get.put(RewardController());
            }
            if (_currentIndex.value == 2) {
              Get.put(HistoryController());
            }
            return views[_currentIndex.value];
          }
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.mainColor,
          child: Icon(Icons.play_arrow_sharp),
          onPressed: () {
            Get.lazyPut(() => QuestPurchasedController());
            Get.to(QuestsPlayPage());
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Obx(
          () {
            return NavigationBar(
              backgroundColor: Colors.white,
              selectedIndex: _currentIndex.value,
              onDestinationSelected: _currentIndex,
              destinations: <NavigationDestination>[
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'home'.tr,
                ),
                NavigationDestination(
                  icon: Icon(Icons.card_giftcard),
                  label: 'reward'.tr,
                ),
                NavigationDestination(
                  icon: Icon(Icons.history_sharp),
                  label: 'history'.tr,

               
                ),
                NavigationDestination(
                  icon: Icon(Icons.account_circle),
                  label: 'profile'.tr,
                ),
              ],
            );
          },
        ));
  }
}
