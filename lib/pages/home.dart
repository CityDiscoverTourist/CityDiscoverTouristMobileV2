// ignore: depend_on_referenced_packages
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:travel_hour/pages/guide.dart';

import 'package:travel_hour/pages/profile.dart';
import '../controllers/home_controller.dart';
import 'explore.dart';
import 'history.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myController = Get.find<HomeController>();
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
      return views[_currentIndex.value];
    }), bottomNavigationBar: Obx(
      () {
        return BottomNavyBar(
          selectedIndex: _currentIndex.value,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: _currentIndex,
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Colors.red,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text('Users'),
              activeColor: Colors.purpleAccent,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.history_sharp),
              title: Text(
                'History ',
              ),
              activeColor: Colors.pink,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile'),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    ));
  }
}
