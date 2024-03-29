import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/config/colors.dart';
import 'package:travel_hour/config/config.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/pages/history.dart';
import 'package:travel_hour/pages/profile.dart';

import '../controllers/history_controller.dart';
import '../controllers/language_controller.dart';
import '../pages/splashV2.dart';

class LanguagePopup extends StatefulWidget {
  const LanguagePopup({Key? key}) : super(key: key);

  @override
  _LanguagePopupState createState() => _LanguagePopupState();
}

class _LanguagePopupState extends State<LanguagePopup> {
  LanguegeController languageController = new LanguegeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor:AppColors.mainColor,
        title: Text('select language'.tr),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: Config().languages.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemList(Config().languages[index], index);
        },
      ),
    );
  }

  Widget _itemList(d, index) {
    return Column(
      children: [
        ListTile(
          leading: Icon(LineIcons.language),
          title: Text(
            d,
          ),
          onTap: () async {
            if (d == 'English') {
              languageController.changeLanguage('en');
              Get.find<LoginControllerV2>().language.value = 0;
               if(Get.isRegistered<HistoryController>()==true){
                Get.off(HistoryPage());
                  Get.find<HistoryController>().refeshData();
                }
              Get.find<HomeController>().updateData();
            } else if (d == 'Spanish') {
              // context.setLocale(Locale('es'));
            } else if (d == 'Arabic') {
              languageController.changeLanguage('ar');
            } else if (d == 'Vietnamese') {
              Get.find<LoginControllerV2>().language.value = 1;
              languageController.changeLanguage('vn');
               if(Get.isRegistered<HistoryController>()==true){
                 Get.off(HistoryPage());
                  Get.find<HistoryController>().refeshData();
                }
              Get.find<HomeController>().updateData();
            }

            Navigator.pop(context);
          },
        ),
        Divider(
          height: 5,
          color: Colors.grey[400],
        )
      ],
    );
  }
}
