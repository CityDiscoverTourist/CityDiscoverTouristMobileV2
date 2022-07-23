// ignore: depend_on_referenced_packages
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/history_controller.dart';
import 'package:travel_hour/pages/guide.dart';
import 'package:travel_hour/pages/quest_play.dart';

import 'package:travel_hour/pages/profile.dart';
import 'package:travel_hour/pages/splashV2.dart';
import '../controllers/home_controller.dart';
import 'explore.dart';
import 'history.dart';

class HomePage extends StatelessWidget {
    HomeController myController =  Get.put(HomeController());
  @override
  Widget build(BuildContext context)  {

    var _currentIndex = myController.indexHomePage;
    final views = [
      Explore(),
      GuidePage(),
      HistoryPage(),
      ProfilePage(),
    ];
    return Scaffold(
        // appBar: AppBar(title: Text("Flutter Demo")),
        body: Obx(() {
          if(myController.isLoading.value==true){
            // print("true nef");
            return SplashStart(content: 'Waiting Loading Data...',);
          }else
          return views[_currentIndex.value];
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.play_arrow_sharp),
          onPressed: () {Get.put(HistoryController());Get.to(QuestsPlayPage());},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Obx(
          () {
            return NavigationBar(
              backgroundColor: Colors.white,
              selectedIndex: _currentIndex.value,
              // showElevation: true,
              // itemCornerRadius: 24,
              // curve: Curves.easeIn,
              onDestinationSelected: _currentIndex,
              destinations: <NavigationDestination>[
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.people),
                  label: 'Users',
                  // activeColor: Colors.purpleAccent,
                  // textAlign: TextAlign.center,
                ),
                NavigationDestination(
                  icon: Icon(Icons.history_sharp),
                  label: 'History ',

                  // activeColor: Colors.pink,
                  // textAlign: TextAlign.center,
                ),
                NavigationDestination(
                  icon: Icon(Icons.account_circle),
                  label: 'Profile',
                ),
              ],
            );
          },
        ));
  }
}
