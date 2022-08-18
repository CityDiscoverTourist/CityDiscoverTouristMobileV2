import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/config/colors.dart';
import 'package:travel_hour/models/quest_detail.dart';
import 'package:travel_hour/pages/comments_v2.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/small_text.dart';

import '../controllers/comment_controller.dart';

class TodoWidgetV2 extends StatelessWidget {
  final QuestDetail? questDetailModel;
  const TodoWidgetV2({Key? key, required this.questDetailModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('you should know'.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            )),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          height: 3,
          width: 50,
          decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(40)),
        ),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: GridView.count(
            padding: EdgeInsets.all(0),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              InkWell(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.blueAccent[400]!,
                                        offset: Offset(5, 5),
                                        blurRadius: 2)
                                  ]),
                              child: Icon(
                                LineIcons.walking,
                                size: 30,
                              ),
                            ),
                            Expanded(
                              child: SmallText(
                                text: 'total distance:'.tr,
                                color: Colors.white,
                              ),
                              flex: 1,
                            ),
                            BigText(
                              text: questDetailModel!.estimatedDistance
                                      .toString() +
                                  ' km',
                              color: Colors.white,
                            ),
                          ])),
                  onTap: () => () {}
                  //  nextScreen(context, GuidePage(d: questData)),
                  ),
              InkWell(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.orangeAccent[400]!,
                                        offset: Offset(5, 5),
                                        blurRadius: 2)
                                  ]),
                              child: Icon(
                                Icons.timelapse,
                                size: 30,
                              ),
                            ),
                            Expanded(
                              child: SmallText(
                                text: 'total time:'.tr,
                                color: Colors.white,
                              ),
                              flex: 1,
                            ),
                            BigText(
                              text: questDetailModel!.estimatedTime.toString() +" "+
                                  'minutes'.tr,
                              color: Colors.white,
                            ),
                          ])),
                  onTap: () => {}),
              InkWell(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.pinkAccent[400]!,
                                        offset: Offset(5, 5),
                                        blurRadius: 2)
                                  ]),
                              child: Icon(
                                Icons.location_on,
                                size: 30,
                              ),
                            ),
                            Expanded(
                              child: SmallText(
                                text: 'number of question:'.tr,
                                color: Colors.white,
                              ),
                              flex: 1,
                            ),
                            BigText(
                              text: questDetailModel!.countQuestItem.toString(),
                              color: Colors.white,
                            ),
                          ])),
                  onTap: () => {}
                  //  nextScreen(context, RestaurantPage(placeData: questData,)),
                  ),
              InkWell(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.indigoAccent[400]!,
                                        offset: Offset(5, 5),
                                        blurRadius: 2)
                                  ]),
                              child: Icon(
                                LineIcons.comments,
                                size: 30,
                              ),
                            ),
                            Expanded(
                              child: BigText(
                                text: 'user reviews'.tr,
                                color: Colors.white,
                              ),
                              flex: 1,
                            )
                            // BigText(
                            //   text: 'user reviews'.tr,
                            //   color: Colors.white,
                            // ),
                          ])),
                  onTap: () async => {
                        print("TODO :" + questDetailModel!.id.toString()),

                        Get.put(CommentController()).idQuest.value =
                            questDetailModel!.id,
                        Get.to(CommentsPageV2()),
                        //        Get.put(CommentControllerv4()).idQuest.value =
                        //     questDetailModel!.id,
                        // Get.to(CommentsPageV4())
                      }
                  //  nextScreen(context, CommentsPage(collectionName: 'places', timestamp: questData!.timestamp,)),
                  ),
            ],
          ),
        )
      ],
    );
  }
}
