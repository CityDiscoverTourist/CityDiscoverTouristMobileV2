import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/customer_quest.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/utils/empty.dart';
import 'package:travel_hour/utils/list_card_history.dart';

import '../config/colors.dart';
import '../controllers/history_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with AutomaticKeepAliveClientMixin {
  // var controller = Get.find<HomeController>();
  List<CustomerQuest> list = Get.find<HistoryController>().historyQuestList;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Obx(()=> 
    Get.find<HistoryController>().isLoading.isTrue?SplashStart():
    DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('playing history'.tr),
            centerTitle: false,
            titleSpacing: 20,
            backgroundColor: AppColors.mainColor,
          ),
          body: RefreshIndicator(
              child: Container(
                child: list.isEmpty
                    ? EmptyPage(
                        icon: Feather.bookmark,
                        message: 'no playing history found'.tr,
                        message1: ''.tr,
                      )
                    : ListView.separated(
                        padding: EdgeInsets.all(5),
                        itemCount: list.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ListCardHistory(
                            d: list[index],
                            tag: "bookmark$index",
                            color: Colors.white,
                          );
                        },
                      ),
              ),
              onRefresh: _onRefresh)),
    ));
  }

  @override
  bool get wantKeepAlive => true;
  Future<void> _onRefresh() async {
    Get.find<HistoryController>()
        .fetchPlayingHistory(Get.find<LoginControllerV2>().sp.id);
  }
}
