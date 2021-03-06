import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/pages/intro.dart';
import 'package:travel_hour/utils/next_screen.dart';

import '../utils/empty.dart';
import '../widgets/voucher_widget.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  _VoucherPageState createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(milliseconds: 3000))
    //     .then((_) => nextScreenReplace(context, IntroPage()));
  }

  @override
  Widget build(BuildContext context) {
    List<int> text = [1, 2, 3, 4];
    return Scaffold(
      appBar: AppBar(
        title: Text("your reward".tr),
      ),
      body: SingleChildScrollView(
        child: Get.find<HomeController>().rewardList.isEmpty
            ? EmptyPage(
                icon: Icons.card_giftcard,
                message: 'no reward found'.tr,
                message1: ''.tr,
              )
            : Column(
                children: List.generate(
                    Get.find<HomeController>().rewardList.length, (index) {
                  return VoucherWidget(
                    reward: Get.find<HomeController>().rewardList[index],
                  );
                }),
              ),
      ),
    );
  }
}
