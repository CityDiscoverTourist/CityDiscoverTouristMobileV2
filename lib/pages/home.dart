// ignore: depend_on_referenced_packages
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:travel_hour/pages/profile.dart';
import '../controllers/home_controller.dart';
import 'explore.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);

//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   PageController _pageController = PageController();
//   // final scaffoldKey = GlobalKey<ScaffoldState>();

//   List<IconData> iconList = [
//     Feather.home,
//     Feather.list,
//     Feather.bookmark,
//     Feather.user
//   ];

//   void onTabTapped(int index) {
//     setState(() => _currentIndex = index);
//     _pageController.animateToPage(index,
//         curve: Curves.easeIn, duration: Duration(milliseconds: 300));
//   }

//   Future _onWillPop() async {
//     if (_currentIndex != 0) {
//       setState(() => _currentIndex = 0);
//       _pageController.animateToPage(0,
//           duration: Duration(milliseconds: 300), curve: Curves.easeIn);
//     } else {
//       await SystemChannels.platform
//           .invokeMethod<void>('SystemNavigator.pop', true);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Get.put(HomeController());

//     return WillPopScope(
//       onWillPop: () async => await _onWillPop(),
//       child: Scaffold(
//         // key: scaffoldKey,
//         bottomNavigationBar: AnimatedBottomNavigationBar(
//           icons: iconList,
//           activeColor: Theme.of(context).primaryColor,
//           gapLocation: GapLocation.none,
//           activeIndex: _currentIndex,
//           inactiveColor: Colors.grey[500],
//           splashColor: Theme.of(context).primaryColor,
//           iconSize: 22,
//           onTap: (index) => onTabTapped(index),

//         ),
//         body: PageView(
//           controller: _pageController,
//           physics: NeverScrollableScrollPhysics(),
//           children: <Widget>[
//             Explore(),
//             // StatesPage(),
//             // BlogPage(),
//             // BookmarkPage(),
//             // ProfilePage(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myController = Get.find<HomeController>();
    var _currentIndex = myController.indexHomePage;
    final views = [
      Explore(),
      // quest(),
//             // BlogPage(),
//             // BookmarkPage(),
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
              icon: Icon(Icons.apps),
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
              icon: Icon(Icons.message),
              title: Text(
                'Messages test for mes teset test test ',
              ),
              activeColor: Colors.pink,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    ));
  }
}
