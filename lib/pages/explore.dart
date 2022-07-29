import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/controllers/search_controller.dart';
import 'package:travel_hour/models/city.dart';
import 'package:travel_hour/pages/profile.dart';
import 'package:travel_hour/pages/searchV2.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/custom_cache_image.dart';
import '../../config/config.dart';
import '../controllers/home_controller.dart';

import '../widgets/featured_places.dart';
import '../widgets/quest_type_scroll.dart';

class Explore extends StatefulWidget {
  Explore({Key? key}) : super(key: key);

  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async => () {},
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Header(),
                  FeaturedQuest(),
                  QuestTypeScroll(),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    Rx<City>? dropdownValue = Rx<City>(controller.dropdownValue);
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BigText(
                      text: Config().appName,
                      size: 22,
                      fontWeight: FontWeight.w900,
                    ),
                    Obx(
                      () => DropdownButton<City>(
                        //isDense: true,
                        // hint: controller.cityChoice,
                        value: dropdownValue.value,
                        icon: Icon(Icons.location_city),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.blue[300],
                        ),
                        onChanged: (City? newValue) {
                          controller.dropdownValue = newValue!;
                          dropdownValue.value = newValue;
                          //Get Id City for reload List Quest
                          controller.areaIdChoice.value = newValue.id;
                        },
                        items: controller.cityList
                            .map<DropdownMenuItem<City>>((City value) {
                          return DropdownMenuItem<City>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
                Spacer(),
                InkWell(
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(Get.find<LoginControllerV2>()
                        .firebaseAuth
                        .currentUser!
                        .photoURL
                        .toString()),
                    backgroundColor: Colors.transparent,
                  ),
                  onTap: () {
                    Get.to(ProfilePage());
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 5, right: 5),
              padding: EdgeInsets.only(left: 15, right: 15),
              height: 45,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey[300]!, width: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Feather.search,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // Text(
                    //   'search places',
                    //   style: TextStyle(
                    //       fontSize: 15,
                    //       color: Colors.blueGrey[700],
                    //       fontWeight: FontWeight.w500),
                    // ).tr(),
                    BigText(
                      text: "search places".tr,
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              Get.put(SearchController());
              Get.to(SearchPageV2());
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => SearchPage()));
            },
          )
        ],
      ),
    );
  }
}
