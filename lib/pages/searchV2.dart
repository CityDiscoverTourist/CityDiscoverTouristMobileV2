import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:travel_hour/controllers/home_controller.dart';
// import 'package:travel_hour/blocs/search_bloc.dart';
import 'package:travel_hour/controllers/search_controller.dart';
import 'package:travel_hour/pages/quest_details.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/utils/empty.dart';
import 'package:travel_hour/utils/list_card.dart';
import 'package:travel_hour/utils/loading_cards.dart';
import 'package:travel_hour/utils/snacbar.dart';
import 'package:travel_hour/widgets/big_text.dart';

import '../config/colors.dart';

class SearchPageV2 extends StatelessWidget {
  var controllerS = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        Get.delete<SearchController>();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: _searchBar(),
          automaticallyImplyLeading: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // suggestion text
            Expanded(child: Obx(() {
              if (controllerS.isLoading.value == false) {
                if (controllerS.questList.length != 0) {
                  return ListView.separated(
                    padding: EdgeInsets.all(10),
                    itemCount: controllerS.questList.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // Get.find<HomeController>().idQuestCurrent.value =
                          //     controllerS.questList[index].id;
                          //     print(   Get.find<HomeController>().idQuestCurrent.value);
                          // Get.toNamed(KQuestDetailPage);
                          Get.toNamed(KQuestDetailPage, parameters: {
                            'idQuest': controllerS.questList[index].id.toString()
                          });
                        },
    
                        // Get.to(QuestDetails(
                        //     data: controllerS.questList[index], tag: "tag")),
                        child: ListCard(
                          d: controllerS.questList[index],
                          tag: "search$index",
                          color: Colors.white,
                        ),
                      );
    
                      // ListCard(
                      //   d: controllerS.questList[index],
                      //   tag: "search$index",
                      //   color: Colors.white,
                      // );
                    },
                  );
                } else {
                  print('abc');
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info,
                          size: 50,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BigText(text: 'Not Found'),
                      ],
                    ),
                  );
                }
              } else {
                return SplashStart();
              }
            }))
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: TextFormField(
        autofocus: true,
        controller: controllerS.textFieldCtrl,
        style: TextStyle(
            fontSize: 16, color: Colors.grey[800], fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "search & explore".tr,
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800]),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.grey[800],
              size: 25,
            ),
            onPressed: () {
              controllerS.textFieldCtrl.text = "";
              // context.read<SearchBloc>().saerchInitialize();
//Clear Text
            },
          ),
        ),
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          controllerS.textSearch.value = controllerS.textFieldCtrl.text;
        },
        // onFieldSubmitted: (value) {
        //   if (value == '') {
        //     // openSnacbar(scaffoldKey, 'Type something!');
        //   } else {
        //     // context.read<SearchBloc>().setSearchText(value);
        //     // context.read<SearchBloc>().addToSearchList(value);
        //   }
        // },
      ),
    );
  }
}
