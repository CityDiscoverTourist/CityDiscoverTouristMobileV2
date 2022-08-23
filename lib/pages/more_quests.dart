import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:travel_hour/controllers/loadquest_controller.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/widgets/big_text.dart';

import '../models/quest.dart';
import '../widgets/custom_cache_image.dart';

// class MoreQuestPage extends StatefulWidget {
//   // final String title;
//   final Color? color;
//   MoreQuestPage({Key? key, required this.color})
//       : super(key: key);

//   @override
//   _MoreQuestPageState createState() => _MoreQuestPageState();
// }

// class _MoreQuestPageState extends State<MoreQuestPage> {
class MoreQuestPage extends GetView<LoadQuestController> {
  final Color? color;
  MoreQuestPage({Key? key, required this.color}) : super(key: key);
  final String collectionName = 'places';
  ScrollController? controllerScroll;
  // late bool _isLoading;
  // late bool _descending;
  // late String _orderBy;

  @override
  Widget build(BuildContext context) {
    // var myController = Get.find<HomeController>();
    return Obx(() => controller.isLoading.isTrue
        ? SplashStart()
        : Scaffold(
            body: RefreshIndicator(
              child: CustomScrollView(
                controller: controllerScroll,
                slivers: <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: true,
                    pinned: true,
                    // actions: <Widget>[
                    //   IconButton(
                    //     icon: Icon(
                    //       Icons.keyboard_arrow_left,
                    //       color: Colors.white,
                    //     ),
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     },
                    //   )
                    // ],
                    backgroundColor: color,
                    expandedHeight: 140,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      background: Container(
                        color: color,
                        height: 140,
                        width: double.infinity,
                      ),
                      title: BigText(
                        // text: widget.title,
                        text: Get.parameters['title'].toString(),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      titlePadding:
                          EdgeInsets.only(left: 20, bottom: 15, right: 15),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(15),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return
                              //                    controller.questList.length==0?
                              // // EmptyPage(
                              // //         icon: Icons.card_giftcard,
                              // //         message: 'no reward found'.tr,
                              // //         message1: ''.tr,
                              // //       )
                              // // Center(child: Text("hhhhhhhhh"),)
                              //       :
                              _ListItem(
                            q: controller.questList[index],
                            // tag: '${widget.title}$index',
                          );
                        },
                        childCount: controller.questList.length,
                      ),
                    ),
                  )
                ],
              ),
              onRefresh: () async => () {},
            ),
          ));
  }
}

class _ListItem extends StatelessWidget {
  final Quest q;
  // final tag;
  const _ListItem({
    Key? key,
    required this.q,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          margin: EdgeInsets.only(top: 5, bottom: 10),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 10,
                        offset: Offset(0, 3))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      child: Hero(
                        tag: 'tag',
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            child: q.imagePath != null
                                ? CustomCacheImage(imageUrl: q.imagePath)
                                : Image.asset('assets/images/logo.png')),
                      )),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: q.title,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RatingBarIndicator(
                                rating: q.averageStar.toDouble(),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 10.0,
                                direction: Axis.horizontal,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(q.averageStar.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(q.totalFeedback.toString() + 'comments'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            Spacer(),
                            Spacer()
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: Text(
                                // d.location!,
                                // q.description,
                                q.address!,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey[300],
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              LineIcons.clockAlt,
                              size: 24,
                              color: Colors.orange,
                            ),
                            BigText(
                              text: q.estimatedTime + 'minutes'.tr,
                              size: 16,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              LineIcons.walking,
                              size: 18,
                              color: Colors.orange,
                            ),
                            BigText(
                              text: q.estimatedDistance + ' km',
                              size: 16,
                            ),
                            Spacer(),
                            Container(
                              child: Center(
                                  child: BigText(
                                text:
                                    //  q.price.truncate().toString()
                                    MoneyFormatter(amount: q.price)
                                            .output
                                            .withoutFractionDigits
                                            .toString() +
                                        " VNĐ",
                                fontWeight: FontWeight.w700,
                              )),
                              width: MediaQuery.of(context).size.width * 0.30,
                              height: 35,
                              decoration: BoxDecoration(
                                  color: Color(0xFFFF9C00),
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        onTap: () {
          // Get.find<HomeController>().idQuestCurrent.value = q.id;
          Get.toNamed(KQuestDetailPage,
              parameters: {'idQuest': q.id.toString()});
        }
        // => Get.to(() => QuestDetails(data: q, tag: tag)),
        );
  }
}
