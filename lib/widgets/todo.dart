import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/models/place.dart';
import 'package:travel_hour/models/quest.dart';
import 'package:travel_hour/pages/comments.dart';
import 'package:travel_hour/pages/comments_v2.dart';
import 'package:travel_hour/pages/guide.dart';
import 'package:travel_hour/pages/hotel.dart';
import 'package:travel_hour/pages/restaurant.dart';
import 'package:travel_hour/utils/next_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/small_text.dart';

import '../controllers/comment_controller.dart';

class TodoWidget extends StatelessWidget {
  final Quest? questData;
  const TodoWidget({Key? key, required this.questData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Bạn nên biết',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            )).tr(),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          height: 3,
          width: 50,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
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
                      padding: EdgeInsets.all(15),
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
                              SmallText(
                              text:
                              'Tổng quãng đường: ',color: Colors.white,
                            ),
                            BigText(
                              text:
                              questData!.estimatedDistance.toString() + ' km',color: Colors.white,
                            ),
                          ])),
                  onTap: () => () {}
                  //  nextScreen(context, GuidePage(d: questData)),
                  ),
              InkWell(
                  child: Container(
                      padding: EdgeInsets.all(15),
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
                             SmallText(
                              text:
                              'Tổng thời gian: ',color: Colors.white,
                            ),
                            BigText(
                              text:
                              questData!.estimatedTime.toString() + ' phút',color: Colors.white,
                            ),
                          ])),
                  onTap: () => {}),
              InkWell(
                  child: Container(
                      padding: EdgeInsets.all(15),
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
                           SmallText(
                              text:
                              'Số lượng câu đố: ',color: Colors.white,
                            ),
                            BigText(
                              text:
                              questData!.countQuestItem.toString() ,color: Colors.white,
                            ),
                          ])),
                  onTap: () => {}
                  //  nextScreen(context, RestaurantPage(placeData: questData,)),
                  ),
              InkWell(
                  child: Container(
                      padding: EdgeInsets.all(15),
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
                           
                            BigText(
                              text:
                              'Đánh giá',color: Colors.white,
                            ),
                          ])),
                  onTap: () => {
                    print("TODO :"+questData!.id.toString()),
                        Get.put(CommentController()).idQuest.value =
                            questData!.id,
                        Get.to(CommentsPageV2())
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
