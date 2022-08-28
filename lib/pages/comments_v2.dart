import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:travel_hour/config/colors.dart';
// import 'package:travel_hour/blocs/comments_bloc.dart';
// import 'package:travel_hour/blocs/sign_in_bloc.dart';
import 'package:travel_hour/controllers/comment_controller.dart';
import 'package:travel_hour/models/comment.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/utils/loading_cards.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/small_text.dart';

class CommentsPageV2 extends StatefulWidget {
  const CommentsPageV2({
    Key? key,
  }) : super(key: key);

  @override
  _CommentsPageV2State createState() => _CommentsPageV2State();
}

class _CommentsPageV2State extends State<CommentsPageV2> {
  ScrollController? controller;
  var myController = Get.find<CommentController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var textCtrl = TextEditingController();
  bool? _hasData;

  @override
  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

//Để lại
  void _scrollListener() {
    if (!myController.isLoading.value) {
      if (controller!.position.pixels == controller!.position.maxScrollExtent) {
        myController.increaseIndex();
        print('object');
        // myController.getCommentData();
        // myController.isMoreLoading(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppColors.mainColor,
          title: Text('comments'.tr),
          titleSpacing: 0,
          actions: [
            IconButton(
                icon: Icon(
                  Feather.rotate_cw,
                  size: 22,
                ),
                //RefeshData Comments
                onPressed: () => myController.refeshData())
          ],
        ),
        body: Obx(
          () => myController.isLoading.isTrue
              ? SplashStart()
              : Column(
                  children: [
                    Expanded(
                        child: Obx(() => RefreshIndicator(
                            child: ListView.separated(
                              padding: EdgeInsets.all(15),
                              controller: controller,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: myController.dataComment.length,
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                height: 10,
                              ),
                              itemBuilder: (_, int index) {
                                if (index <
                                    myController.dataComment.length) {
                                  return reviewList(
                                      myController.dataComment[index], false);
                                }
                                return Opacity(
                                  opacity:
                                      myController.isLoading.value ? 1.0 : 0.0,
                                  child: myController.lastVisible.isTrue
                                      ? LoadingCard(height: 100)
                                      : Center(
                                          child: SizedBox(
                                              width: 60.0,
                                              height: 60.0,
                                              child:
                                                  CupertinoActivityIndicator()),
                                        ),
                                );
                              },
                            ),
                            onRefresh: () async {
                              myController.refeshData();
                            }))
                        // }
                        ),

                    // ),
                    // ),
                    Divider(
                      height: 1,
                      color: Colors.black26,
                    ),
                  ],
                ),
        ));
  }

  Widget reviewList(Comment d, bool isCommented) {
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(5)),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[200],
            child:
                // d.imageUrl!=null?CachedNetworkImageProvider(imageUrl: d.imageUrl):Image.asset('assets/images/logo.png'),
                d.imagePath != null
                    ? CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage("${d.imagePath}"),
                        backgroundColor: Colors.transparent,
                      )
                    : CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                            "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000"),
                        backgroundColor: Colors.transparent,
                      ),

            // d.imageUrl!=null?CachedNetworkImage(imageUrl: d.imageUrl):Image.asset('assets/images/logo.png'),
          ),
          title: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      d.name.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RatingBarIndicator(
                      rating: d.rating.toDouble(),
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 10.0,
                      direction: Axis.horizontal,
                    ),
                    isCommented == true
                        ? TextButton(
                            onPressed: () {
                              Get.find<CommentController>().isCommented.value =
                                  2;
                            },
                            child: SmallText(
                              text: 'Edit',
                              color: Colors.blue,
                            ))
                        : SizedBox.shrink()
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(d.createdDate.toString(),
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 11,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          subtitle: d.feedBack != null
              ? BigText(text: d.feedBack.toString())
              : BigText(text: ""),
          onLongPress: () {
            // openPopupDialog(d);
          },
        ));
  }
}
