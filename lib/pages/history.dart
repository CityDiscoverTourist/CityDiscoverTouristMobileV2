import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/quest.dart';
import 'package:travel_hour/utils/empty.dart';
import 'package:travel_hour/utils/list_card.dart';
import 'package:travel_hour/utils/loading_cards.dart';

import '../controllers/home_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with AutomaticKeepAliveClientMixin {
  var controller = Get.find<HomeController>();
  List<Quest> list = Get.find<HomeController>().hisQuestList;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('playing history'.tr),
            centerTitle: false,
            titleSpacing: 20,
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
                          return ListCard(
                            d: list[index],
                            tag: "bookmark$index",
                            color: Colors.white,
                          );
                        },
                      ),
              ),
              onRefresh: _onRefresh)),
    );
  }

  @override
  bool get wantKeepAlive => true;
  Future<void> _onRefresh() async {
    Get.find<HomeController>()
        .fetchPlayingHistory(Get.find<LoginControllerV2>().sp.id);
  }
}
