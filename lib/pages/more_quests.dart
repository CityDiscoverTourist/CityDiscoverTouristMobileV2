import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:travel_hour/pages/quest_details.dart';
import 'package:travel_hour/widgets/big_text.dart';

import '../controllers/home_controller.dart';
import '../models/quest.dart';
import '../widgets/custom_cache_image.dart';

class MoreQuestPage extends StatefulWidget {
  final String title;
  final Color? color;
  MoreQuestPage({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  _MoreQuestPageState createState() => _MoreQuestPageState();
}

class _MoreQuestPageState extends State<MoreQuestPage> {
  final String collectionName = 'places';
  ScrollController? controller;
  late bool _isLoading;
  late bool _descending;
  late String _orderBy;

  @override
  Widget build(BuildContext context) {
    var myController = Get.find<HomeController>();
    return Scaffold(
      body: RefreshIndicator(
        child: CustomScrollView(
          controller: controller,
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
              backgroundColor: widget.color,
              expandedHeight: 140,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: Container(
                  color: widget.color,
                  height: 140,
                  width: double.infinity,
                ),
                title: BigText(
                  text: widget.title,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                titlePadding: EdgeInsets.only(left: 20, bottom: 15, right: 15),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(15),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _ListItem(
                      q: myController.questList[index],
                      tag: '${widget.title}$index',
                    );
                  },
                  childCount: myController.questList.length,
                ),
              ),
            )
          ],
        ),
        onRefresh: () async => () {},
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final Quest q;
  final tag;
  const _ListItem({Key? key, required this.q, required this.tag})
      : super(key: key);

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
                      tag: tag,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          child: CustomCacheImage(imageUrl: q.imagePath)),
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
                              rating: 3.5,
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
                          Text('3.5',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(
                            width: 10,
                          ),
                          Text('523 comments',
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
                          BigText(
                            text: 'Công viên nước đầm sen',
                            size: 14,
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
                            text: q.estimatedTime + ' minutes',
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
                              text: q.price.toStringAsFixed(00) + " vnđ",
                              fontWeight: FontWeight.w700,
                            )),
                            width: MediaQuery.of(context).size.width * 0.25,
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
      onTap: () => Get.to(() => QuestDetails(data: q, tag: tag)),
    );
  }
}
