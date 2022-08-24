import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/widgets/big_text.dart';

import '../controllers/home_controller.dart';
import '../models/quest_type.dart';
import '../widgets/custom_cache_image.dart';

class QuestTypePage extends StatefulWidget {
  QuestTypePage({Key? key}) : super(key: key);

  @override
  _QuestTypePageState createState() => _QuestTypePageState();
}

class _QuestTypePageState extends State<QuestTypePage>
    with AutomaticKeepAliveClientMixin {
  ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var myController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF9C00),
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: BigText(
          text: "quest type".tr,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: RefreshIndicator(
        child: ListView.separated(
          padding: EdgeInsets.all(15),
          controller: controller,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: myController.questTypeList.length,
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 10,
          ),

          // shrinkWrap: true,
          itemBuilder: (_, int index) {
            return _ItemList(d: myController.questTypeList[index]);
          },
        ),
        onRefresh: () async {},
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ItemList extends StatelessWidget {
  final QuestType d;
  const _ItemList({Key? key, required this.d}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
            height: 140,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: d.imagePath != null
                        ? CustomCacheImage(imageUrl: d.imagePath)
                        : Image.asset('assets/images/logo.png'),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    d.name.toUpperCase(),
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            )),
        onTap: () {
          // Get.toNamed(YourRouteName.name, parameters: data);
          Get.toNamed(KQuestByType, parameters: {
            "title": d.name,
            "idQuestType": d.id.toString(),
            "idArea": Get.find<HomeController>().areaIdChoice.toString()
          });
        });
    //  Get.to(
    //   MoreQuestPage(
    //     title: d.name,
    //     color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
    //         .withOpacity(1.0))));
  }
}
