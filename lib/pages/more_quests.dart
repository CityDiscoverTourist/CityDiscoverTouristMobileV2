import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:travel_hour/pages/quest_details.dart';

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
                title: Text(
                  '${widget.title}',
                  style: TextStyle(color: Colors.white),
                ).tr(),
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
                      Text(
                        q.title,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            LineIcons.walking,
                            size: 16,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: Text(
                              q.estimatedDistance,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.time,
                            size: 16,
                            color: Colors.grey[700],
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            q.estimatedTime,
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700]),
                          ),
                          Spacer(),
                          Icon(
                            LineIcons.heart,
                            size: 16,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            q.areaId.toString(),
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700]),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            LineIcons.comment,
                            size: 16,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            q.estimatedTime.toString(),
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700]),
                          ),
                        ],
                      )
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
