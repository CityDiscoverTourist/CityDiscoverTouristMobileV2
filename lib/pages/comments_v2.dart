import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:travel_hour/blocs/comments_bloc.dart';
import 'package:travel_hour/blocs/sign_in_bloc.dart';
import 'package:travel_hour/controllers/comment_controller.dart';
import 'package:travel_hour/models/comment.dart';
import 'package:travel_hour/services/app_service.dart';
import 'package:travel_hour/services/comment_service.dart';
import 'package:travel_hour/utils/dialog.dart';
import 'package:travel_hour/utils/empty.dart';
import 'package:travel_hour/utils/loading_cards.dart';
import 'package:travel_hour/utils/sign_in_dialog.dart';
import 'package:travel_hour/utils/toast.dart';
import 'package:easy_localization/easy_localization.dart';

import '../widgets/custom_cache_image.dart';

class CommentsPageV2 extends StatefulWidget {
  const CommentsPageV2({
    Key? key,
  }) : super(key: key);

  @override
  _CommentsPageV2State createState() => _CommentsPageV2State();
}

class _CommentsPageV2State extends State<CommentsPageV2> {
  ScrollController? controller;
  var myController = Get.find<Comment_Controller>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var textCtrl = TextEditingController();
  bool? _hasData;

  @override
  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  // Future<Null> _getData() async {
  //   setState(() => _hasData = true);
  //   await context.read<CommentsBloc>().getFlagList();
  //   QuerySnapshot data;
  //   if (_lastVisible == null)
  //     data = await firestore
  //         .collection('${widget.collectionName}/${widget.timestamp}/comments')
  //         .orderBy('timestamp', descending: true)
  //         .limit(10)
  //         .get();
  //   else
  //     data = await firestore
  //         .collection('${widget.collectionName}/${widget.timestamp}/comments')
  //         .orderBy('timestamp', descending: true)
  //         .startAfter([_lastVisible!['timestamp']])
  //         .limit(10)
  //         .get();

  //   if (data.docs.length > 0) {
  //     _lastVisible = data.docs[data.docs.length - 1];
  //     if (mounted) {
  //       setState(() {
  //          myController.isLoading.value = false;
  //         _snap.addAll(data.docs);
  //         _data = _snap.map((e) => Comment.fromFirestore(e)).toList();
  //         print('blog reviews : ${_data.length}');
  //       });
  //     }
  //   } else {
  //     if (_lastVisible == null) {
  //       setState(() {
  //          myController.isLoading.value = false;
  //         _hasData = false;
  //         print('no items');
  //       });
  //     } else {
  //       setState(() {
  //          myController.isLoading.value = false;
  //         _hasData = true;
  //         print('no more items');
  //       });
  //     }
  //   }
  //   return null;
  // }

  // @override
  // void dispose() {
  //   controller!.removeListener(_scrollListener);
  //   super.dispose();
  // }
//Để lại
  void _scrollListener() {
    if (!myController.isLoading.value) {
      if (controller!.position.pixels == controller!.position.maxScrollExtent) {
        // myController.isMoreLoading.value=true;
        myController.getCommentData();
      }
    }
  }

  // openPopupDialog(Comment d) {
  //   final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);

  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SimpleDialog(
  //           contentPadding: EdgeInsets.all(20),
  //           children: [

  //             context.watch<CommentsBloc>().flagList.contains(d.timestamp)
  //             ? Container()
  //             : ListTile(

  //               title: Text('flag this comment').tr(),
  //               leading: Icon(Icons.flag),
  //               onTap: ()async{
  //                 await context.read<CommentsBloc>().addToFlagList(context, d.timestamp)
  //                 .then((value) => onRefreshData());
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             context.watch<CommentsBloc>().flagList.contains(d.timestamp)
  //             ? ListTile(
  //               title: Text('unflag this comment').tr(),
  //               leading: Icon(Icons.flag_outlined),
  //               onTap: ()async{
  //                 await context.read<CommentsBloc>().removeFromFlagList(context, d.timestamp)
  //                 .then((value) => onRefreshData());
  //                 Navigator.pop(context);
  //               },
  //             )
  //             : Container(),

  //             ListTile(
  //               title: Text('report').tr(),
  //               leading: Icon(Icons.report),
  //               onTap: (){
  //                 handleReport(d);
  //               },
  //             ),
  //             sb.uid == d.uid ?
  //             ListTile(
  //               title: Text('delete').tr(),
  //               leading: Icon(Icons.delete),
  //               onTap: () => handleDelete1(d),
  //             )
  //             : Container()
  //           ],
  //         );
  //       });
  // }

  // Future handleReport (Comment d)async{
  //   final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
  //   if(sb.isSignedIn == true){
  //     await context.read<CommentsBloc>().reportComment(widget.collectionName, widget.timestamp, d.uid, d.timestamp);
  //     Navigator.pop(context);
  //     openDialog(context, 'report-info'.tr(), "report-info1".tr());

  //   }else{
  //     Navigator.pop(context);
  //     openDialog(context, 'report-guest'.tr(), 'report-guest1'.tr());
  //   }
  // }

  // Future handleDelete1(Comment d) async {
  //   final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
  //   await AppService().checkInternet().then((hasInternet)async{
  //     if(hasInternet == false){
  //       Navigator.pop(context);
  //       openToast(context, 'no internet'.tr());
  //     }else{
  //       await context.read<CommentsBloc>().deleteComment(widget.collectionName, widget.timestamp, sb.uid, d.timestamp)
  //       .then((value) => openToast(context, 'Deleted Successfully!'));
  //       onRefreshData();
  //       Navigator.pop(context);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('comments').tr(),
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
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                return RefreshIndicator(
                    child: myController.lastVisible.value == 0
                        ? LoadingCard(height: 100)
                        : ListView.separated(
                            padding: EdgeInsets.all(15),
                            controller: controller,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: myController.dataComment.length + 1,
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                              height: 10,
                            ),
                            itemBuilder: (_, int index) {
                              if (index < myController.dataComment.length) {
                                return reviewList(
                                    myController.dataComment[index]);
                              }

                              return Opacity(
                                opacity:
                                    myController.isLoading.value ? 1.0 : 0.0,
                                child: myController.lastVisible.value == 0
                                    ? LoadingCard(height: 100)
                                    : Center(
                                        child: SizedBox(
                                            width: 60.0,
                                            height: 60.0,
                                            child:
                                                new CupertinoActivityIndicator()),
                                      ),
                              );
                            },
                          ),
                    onRefresh: () async {
                      myController.refeshData();
                    });
              },
            ),
          ),
          Divider(
            height: 1,
            color: Colors.black26,
          ),
          SafeArea(
            child: Container(
              // height: 80,
              padding: EdgeInsets.only(top: 8, bottom: 10, right: 20, left: 20),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    // allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      myController.rating.value=rating.toInt();
                      print(rating+  myController.rating.value);

                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 0),
                          contentPadding:
                              EdgeInsets.only(left: 15, top: 10, right: 5),
                          border: InputBorder.none,
                          hintText: 'Write a comment',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.grey[700],
                              size: 20,
                            ),
                            onPressed: () {
                              myController.handleSubmit(textCtrl.text, context);
                              textCtrl.clear();
                            },
                          )),
                      controller: textCtrl,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget reviewList(Comment d) {
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
                    ? CustomCacheImage(imageUrl: d.imagePath)
                    : Image.asset('assets/images/logo.png'),

            // d.imageUrl!=null?CachedNetworkImage(imageUrl: d.imageUrl):Image.asset('assets/images/logo.png'),
          ),
          title: Row(
            children: <Widget>[
              Text(
                d.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 10,
              ),
              Text(d.createdDate.toString(),
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 11,
                      fontWeight: FontWeight.w500)),
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
            ],
          ),
          subtitle: Text(
            d.feedBack,
            style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
          onLongPress: () {
            // openPopupDialog(d);
          },
        ));
  }
}
