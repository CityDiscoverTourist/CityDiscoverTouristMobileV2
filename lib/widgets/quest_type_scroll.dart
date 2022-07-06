import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:travel_hour/config/colors.dart';
import 'package:travel_hour/widgets/big_text.dart';
import '../controllers/home_controller.dart';

import '../models/quest_type.dart';
import '../pages/more_quests.dart';
import '../pages/quest_type.dart';
import 'custom_cache_image.dart';

class QuestTypeScroll extends StatelessWidget {
  QuestTypeScroll({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final pb = context.watch<PopularPlacesBloc>();
    var controller = Get.find<HomeController>();

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, top: 15, right: 10),
          child: Row(
            children: <Widget>[
              BigText(
                text: "Các thể loại",
                fontWeight: FontWeight.w600,
              ),
              Spacer(),
              IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () => Get.to(QuestTypePage())
                  //  nextScreen(context, MorePlacesPage(title: 'popular', color: Colors.grey[800],)),
                  )
            ],
          ),
        ),
        Container(
          height: 245,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 15, right: 15),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.questTypeList.isEmpty
                ? 3
                : controller.questTypeList.length,
            itemBuilder: (BuildContext context, int index) {
              // if(pb.data.isEmpty) return LoadingPopularPlacesCard();
              return _ItemList(
                q: controller.questTypeList[index],
              );
              //return LoadingCard1();
            },
          ),
        )
      ],
    );
  }
}

class _ItemList extends StatelessWidget {
  final QuestType q;
  const _ItemList({Key? key, required this.q}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: 
        Stack(children: [
        Container(
          margin: EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 20),
          width: MediaQuery.of(context).size.width * 0.40,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(25)),
          child: Stack(
            children: [
              Hero(
                tag: 'popular${q.id}',
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CustomCacheImage(imageUrl: q.imagePath)
                    //  child: Image.network(q.imagePath,fit: BoxFit.fill,),
                    ),
              ),
            ],
          ),
        ),
          Positioned(
                 bottom: 0,
                 left: 0,
                 right: 0,
                 child: Container(
                  child: Align(alignment:Alignment.center,child: BigText(text: q.name,fontWeight: FontWeight.w600,)),
                    margin:
                        EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                        color:Color(0xFFFF9C00),
                        borderRadius: BorderRadius.circular(20))),
               ),
        ]),
        onTap: () => Get.to(MoreQuestPage(title: q.name, color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0))));
  }
}
