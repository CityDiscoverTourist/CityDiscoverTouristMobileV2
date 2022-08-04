import 'dart:async';

// import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:travel_hour/common/customFullScreenDialog.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/models/reward.dart';
import 'package:travel_hour/pages/intro.dart';
import 'package:travel_hour/utils/next_screen.dart';

import '../controllers/login_controller_V2.dart';
import '../utils/empty.dart';
import '../widgets/voucher_widget.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  _VoucherPageState createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  List<Reward> list = new List.empty(growable: true);
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onCreate();
    });
  }

  Future<void> _onRefresh() async {
    CustomFullScreenDialog.showDialog();
    await Get.find<HomeController>()
        .fetchRewardByCustomerId(Get.find<LoginControllerV2>().sp.id);
    setState(() {
      CustomFullScreenDialog.cancelDialog();
      list = Get.find<HomeController>().rewardList;
    });
  }

  Future<void> _onCreate() async {
    if (Get.find<HomeController>().rewardList.isNotEmpty) {
      setState(() {
        list = Get.find<HomeController>().rewardList;
      });
    } else {
      CustomFullScreenDialog.showDialog();
      await Get.find<HomeController>()
          .fetchRewardByCustomerId(Get.find<LoginControllerV2>().sp.id);
      setState(() {
        CustomFullScreenDialog.cancelDialog();
        list = Get.find<HomeController>().rewardList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("your reward".tr),
        ),
        body: RefreshIndicator(
            onRefresh: _onRefresh,
            child: FutureBuilder(
                // future: context.watch<BookmarkBloc>().getPlaceData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (list.isNotEmpty) {
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: List.generate(list.length, (index) {
                      return VoucherWidget(
                        reward: list[index],
                      );
                    }),
                  ),
                );
              }
              return EmptyPage(
                icon: Icons.card_giftcard,
                message: 'no reward found'.tr,
                message1: ''.tr,
              );
            })));
  }
}
