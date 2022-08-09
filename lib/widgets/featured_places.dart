import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/custom_cache_image.dart';

import '../controllers/home_controller.dart';
import '../models/quest.dart';
import '../pages/quest_details.dart';

class FeaturedQuest extends StatefulWidget {
  FeaturedQuest({Key? key}) : super(key: key);

  _FeaturedQuestState createState() => _FeaturedQuestState();
}

class _FeaturedQuestState extends State<FeaturedQuest> {
  var controller = Get.find<HomeController>();
  int position = 0;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 260,
              width: w,
              child: PageView.builder(
                controller: PageController(initialPage: 0),
                scrollDirection: Axis.horizontal,
                itemCount: controller.questList.isEmpty
                    ? 1
                    : controller.questList.length,
                //  itemCount: 5,
                onPageChanged: (index) {
                  // ignore: unnecessary_statements
                  setState(() {
                    position = index;
                  });
                  // controller.questList[index];
                },
                itemBuilder: (BuildContext context, int index) {
                  // if(fb.data.isEmpty) return LoadingFeaturedCard();
                  // return _FeaturedItemList(d: fb.data[index]);
                  // if (fb.data.isEmpty) {
                  //   if (fb.hasData == false) {
                  //     return _EmptyContent();
                  //   } else {
                  //     return LoadingFeaturedCard();
                  //   }
                  // }
                  return _FeaturedItemList(q: controller.questList[index]);
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: DotsIndicator(
                dotsCount: controller.questList.length,
                // position: context.watch<FeaturedBloc>().listIndex.toDouble(),
                position: position.toDouble(),
                decorator: DotsDecorator(
                  color: Colors.black26,
                  activeColor: Colors.black,
                  spacing: EdgeInsets.only(left: 6),
                  size: const Size.square(5.0),
                  activeSize: const Size(20.0, 4.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            )
          ],
        ));
  }
}

class _FeaturedItemList extends StatelessWidget {
  // final Place d;
  // const _FeaturedItemList({Key? key, required this.d}) : super(key: key);
  final Quest q;
  const _FeaturedItemList({Key? key, required this.q}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: w,
      child: InkWell(
          child: Stack(
            children: <Widget>[
              Hero(
                // tag: 'featured${q.createdDate}',
                tag: 'feature',
                child: Container(
                    height: 220,
                    width: w,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: q.imagePath != null
                          ? CustomCacheImage(imageUrl: q.imagePath)
                          : Image.asset('assets/images/logo.png'),
                      // Image.network(q.imagePath)
                    )),
              ),
              Positioned(
                height: 180,
                width: w * 0.70,
                left: w * 0.11,
                bottom: 10,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey[200]!,
                            offset: Offset(0, 2),
                            blurRadius: 2)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                child: BigText(
                              text: q.title,
                              fontWeight: FontWeight.w600,
                            )),
                          ],
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
                            Text(q.averageStar.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                q.totalFeedback.toString() +
                                    " " +
                                    "comments".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            Spacer(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
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
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                LineIcons.clockAlt,
                                size: 24,
                                color: Colors.orange,
                              ),
                              Text(
                                q.estimatedTime + 'minutes'.tr,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700]),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Icon(
                                LineIcons.walking,
                                size: 18,
                                color: Colors.orange,
                              ),
                              Text(
                                q.estimatedDistance + ' km',
                                // 'Comment count',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700]),
                              ),
                              Spacer(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          onTap: (){
          //  Get.to(() => QuestDetails(data: q, tag: q.title))
        
           Get.toNamed(KQuestDetailPage, parameters: {
                          'idQuest': q.id.toString()
                        });
           }
           ),
    );
  }
}

class _EmptyContent extends StatelessWidget {
  const _EmptyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 220,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Text("No contents found!"),
      ),
    );
  }
}
