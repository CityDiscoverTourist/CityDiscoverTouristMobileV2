import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/models/customer_quest.dart';
import 'package:travel_hour/models/place.dart';
import 'package:travel_hour/models/quest.dart';

import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/custom_cache_image.dart';
import 'package:travel_hour/widgets/small_text.dart';

import '../config/colors.dart';

class ListCardHistory extends StatefulWidget {
  final CustomerQuest? d;
  final String tag;
  final Color? color;

  const ListCardHistory(
      {Key? key, required this.d, required this.tag, required this.color})
      : super(key: key);

  @override
  State<ListCardHistory> createState() => _ListCardHistoryState();
}

class _ListCardHistoryState extends State<ListCardHistory> {
  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    return InkWell(
      onTap: () {
        // Get.to(QuestDetails(data: d, tag: tag));
        // Get.find<HomeController>().idQuestCurrent.value =
        //                 d!.id;
        //             Get.toNamed(KQuestDetailPage);
        // Get.toNamed(KQuestDetailPage,
        //     parameters: {'idQuest': d!.questId.toString()});
      },
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 15, bottom: 0),
            //color: Colors.grey[200],
            child: Stack(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(top: 15, left: 25, right: 10, bottom: 10),
                  alignment: Alignment.topLeft,
                  height: 140,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 115, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.d!.questName.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SmallText(text: 'Score achieved'.tr + ": "),
                            BigText(
                              text: widget.d!.endPoint != "null" &&
                                      widget.d!.endPoint != null
                                  ? widget.d!.endPoint.toString() +
                                      "/" +
                                      widget.d!.beginPoint.toString()
                                  : "0" + "/" + widget.d!.beginPoint.toString(),
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              size: 14,
                            ),
                            // SmallText(text: d!.totalFeedback.toString())
                            Expanded(
                              child: Text(
                                widget.d!.createdDate != null
                                    ? '${DateFormat('dd-MM-yyyy').format(widget.d!.createdDate)}'
                                    : "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed(KQuestDetailPage, parameters: {
                                  'idQuest': widget.d!.questId.toString()
                                });
                              },
                              child: Text("Buy again".tr,
                                  style: TextStyle(fontSize: 16)),
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.mainColor,
                                onPrimary: Colors.white,
                                padding: const EdgeInsets.only(
                                    left: 30.0,
                                    top: 16.0,
                                    bottom: 16.0,
                                    right: 30.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 30,
              left: 5,
              child: Hero(
                tag: widget.tag,
                child: Container(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: widget.d!.imagePath != null
                          ? CustomCacheImage(imageUrl: widget.d!.imagePath)
                          : Image.asset('assets/images/logo.png'),
                    )),
              ))
        ],
      ),
      // onTap: ()=> nextScreen(context, PlaceDetails(data: d, tag: tag)),
    );
  }
}

class ListCard1 extends StatelessWidget {
  final Place d;
  final String? tag;
  const ListCard1({Key? key, required this.d, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 5, bottom: 5),
            //color: Colors.grey[200],
            child: Stack(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(top: 5, left: 30, right: 10, bottom: 5),
                  alignment: Alignment.topLeft,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 110, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          d.name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Feather.map_pin,
                              size: 12,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Text(
                                d.location!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8, bottom: 20),
                          height: 2,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              LineIcons.heart,
                              size: 18,
                              color: Colors.orangeAccent,
                            ),
                            Text(
                              d.loves.toString(),
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[600]),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              LineIcons.commentAlt,
                              size: 18,
                              color: Colors.grey[700],
                            ),
                            Text(
                              d.commentsCount.toString(),
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[600]),
                            ),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.031,
              left: 10,
              child: Hero(
                tag: tag!,
                child: Container(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CustomCacheImage(imageUrl: d.imageUrl1))),
              ))
        ],
      ),
      // onTap: ()=> nextScreen(context, PlaceDetails(data: d, tag: tag)),
    );
  }
}
