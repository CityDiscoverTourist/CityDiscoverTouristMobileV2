import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/models/place.dart';
import 'package:travel_hour/models/quest.dart';

import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/custom_cache_image.dart';
import 'package:travel_hour/widgets/small_text.dart';

class ListCard extends StatelessWidget {
  final Quest? d;
  final String tag;
  final Color? color;
  const ListCard(
      {Key? key, required this.d, required this.tag, required this.color})
      : super(key: key);

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
        Get.toNamed(KQuestDetailPage,
            parameters: {'idQuest': d!.id.toString()});
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
                  height: 120,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 115, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          d!.title,
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
                            Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              d!.averageStar.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[700]),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.comment,
                              size: 14,
                              // color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Text(
                                d!.totalFeedback.toString(),
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
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                            ),
                            // SmallText(text: d!.totalFeedback.toString())
                            Expanded(
                              child: Text(
                                d!.address.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        )
                        // Container(
                        //   margin: EdgeInsets.only(top: 8, bottom: 20),
                        //   height: 2,
                        //   width: 120,
                        //   decoration: BoxDecoration(
                        //       color: Colors.blueAccent,
                        //       borderRadius: BorderRadius.circular(20)),
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: <Widget>[
                        //     // Icon(
                        //     //   LineIcons.heart,
                        //     //   size: 18,
                        //     //   color: Colors.orangeAccent,
                        //     // ),
                        //     // Text(
                        //     //   d!.status.toString(),
                        //     //   // 'create day',
                        //     //   style: TextStyle(
                        //     //       fontSize: 13, color: Colors.grey[600]),
                        //     // ),
                        //     // SizedBox(
                        //     //   width: 20,
                        //     // ),
                        //     // Icon(
                        //     //   LineIcons.commentAlt,
                        //     //   size: 18,
                        //     //   color: Colors.grey[700],
                        //     // ),
                        //     // Text(
                        //     //   d!.areaId.toString(),
                        //     //   style: TextStyle(
                        //     //       fontSize: 13, color: Colors.grey[600]),
                        //     // ),
                        //     Spacer(),
                        //   ],
                        // ),
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
                tag: tag,
                child: Container(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: d!.imagePath != null
                          ? CustomCacheImage(imageUrl: d!.imagePath)
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
