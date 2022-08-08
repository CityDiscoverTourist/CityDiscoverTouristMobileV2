import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
// import 'package:travel_hour/pages/start_play.dart';
import 'package:travel_hour/pages/rulepage.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/expanded.dart';
import 'package:travel_hour/widgets/small_text.dart';

import '../controllers/home_controller.dart';
import '../models/quest.dart';
import '../widgets/custom_cache_image.dart';
import '../widgets/payment_widget.dart';
import '../widgets/todo.dart';

class QuestDetails extends StatefulWidget {
  final Quest? data;
  final String? tag;

  const QuestDetails({Key? key, required this.data, required this.tag})
      : super(key: key);

  @override
  _QuestDetailsState createState() => _QuestDetailsState();
}

class _QuestDetailsState extends State<QuestDetails> {
  final String collectionName = 'places';

  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    var totalAmout = (widget.data!.price * quantity);
    return WillPopScope(
      onWillPop: () async{
       return false; 
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    widget.tag == null
                        ? _slidableImages()
                        : Hero(
                            tag: widget.tag!,
                            child: _slidableImages(),
                          ),
                    Positioned(
                      top: 20,
                      left: 15,
                      child: SafeArea(
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.9),
                          child: IconButton(
                            icon: Icon(
                              LineIcons.arrowLeft,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 0,
                      child: Row(
                        children: <Widget>[
                          // LoveCount(
                          //     collectionName: collectionName,
                          //     timestamp: widget.data!.timestamp),
                          Icon(
                            Feather.share_2,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            Feather.heart,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          // CommentCount(
                          //     collectionName: collectionName,
                          //     timestamp: widget.data!.timestamp)
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 8, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      BigText(
                        text: widget.data!.title,
                        fontWeight: FontWeight.w600,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Infomation : title, rating, comments,first location
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.data!.averageStar != null ||
                                            widget.data!.averageStar != 0
                                        ? SmallText(
                                            text: widget.data!.averageStar
                                                .toString())
                                        : SmallText(text: "5"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    RatingBarIndicator(
                                      rating: widget.data!.averageStar != null ||
                                              widget.data!.averageStar != 0
                                          ? widget.data!.averageStar.toDouble()
                                          : 5,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 10.0,
                                      direction: Axis.horizontal,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    SmallText(
                                        text: widget.data!.totalFeedback
                                                .toString() +
                                            ' ' +
                                            'comments'.tr),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8, bottom: 8),
                                  height: 3,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(40)),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    SmallText(
                                      text: widget.data!.address.toString(),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Devider(),
                          Divider(),
                          //Infomation: price
                          Expanded(
                            child: Container(
                              child: Center(
                                  child: BigText(
                                text: widget.data!.price.toStringAsFixed(00) +
                                    " vnđ",
                                fontWeight: FontWeight.w700,
                              )),
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: 35,
                              decoration: BoxDecoration(
                                  color: Color(0xFFFF9C00),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                      //Information: Description
                      Padding(
                          padding: EdgeInsets.all(30),
                          child:
                              // Text(
                              //   widget.data!.description,
                              //   textAlign: TextAlign.justify,
                              //   style: TextStyle(
                              //     fontFamily: 'RobotoMono',
                              //     fontSize: 16,
                              //   ),
                              // ),
                              ExpandedWidget(text: widget.data!.description)),
                    ],
                  ),
                ),
    
                // HtmlBodyWidget(
                //   content: widget.data!.description,
                //   isIframeVideoEnabled: true,
                //   isVideoEnabled: true,
                //   isimageEnabled: true,
                //   fontSize: 17,
                // ),
    
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TodoWidget(questData: widget.data),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1)
              ],
            ),
          ),
          // Positioned(
          //     bottom: 0,
          //     child: Container(
          //         color: Colors.white,
          //         width: MediaQuery.of(context).size.width,
          //         height: MediaQuery.of(context).size.height * 0.075,
          //         child: Column(
          //           children: [
          //             Divider(
          //               thickness: 2,
          //               color: Colors.amber,
          //               height: 10,
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Padding(
          //                     padding: const EdgeInsets.only(left: 20),
          //                     child: BigText(
          //                       text: widget.data!.price.toString() + " VNĐ",
          //                       color: Colors.green,
          //                       size: 32,
          //                       fontWeight: FontWeight.w600,
          //                     )),
          //                 Padding(
          //                   padding: const EdgeInsets.only(right: 20.0),
          //                   child: ElevatedButton(
          //                     onPressed: () {
          //                       Get.to(StartPage());
          //                     },
          //                     child: BigText(
          //                       text: 'MUA',
          //                       fontWeight: FontWeight.w600,
          //                       color: Colors.white,
          //                     ),
          //                     style: ElevatedButton.styleFrom(
          //                       padding: const EdgeInsets.only(
          //                           left: 40.0,
          //                           top: 16.0,
          //                           bottom: 16.0,
          //                           right: 40.0),
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius:
          //                             BorderRadius.circular(12), // <-- Radius
          //                       ),
          //                     ),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ],
          //         )))
          Positioned(
            bottom: 0,
            child:
                //  Container(
                //   color: Colors.white,
                //   width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height * 0.075,
                // )
                InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  )),
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter mystate) {
                      return Container(
                        height: 600,
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 70.0, 20.0, 20.0),
                        child: Column(
                          children: <Widget>[
                            PaymentWidget(
                              quest: widget.data!,
                              quantity: quantity,
                              totalAmout: totalAmout,
                            ),
                            // Container(
                            //   padding: EdgeInsets.all(3),
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //       color: Theme.of(context).accentColor),
                            //   child: Row(
                            //     children: [
                            //       RaisedButton(
                            //           onPressed: () async {
                            //             mystate(() {
                            //               quantity = quantity - 1;
                            //             });
                            //           },
                            //           child: Icon(
                            //             Icons.remove,
                            //             color: Colors.white,
                            //             size: 16,
                            //           )),
                            //       Container(
                            //         margin: EdgeInsets.symmetric(horizontal: 3),
                            //         padding: EdgeInsets.symmetric(
                            //             horizontal: 3, vertical: 2),
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(3),
                            //             color: Colors.white),
                            //         child: Text(
                            //           quantity.toString(),
                            //           style: TextStyle(
                            //               color: Colors.black, fontSize: 16),
                            //         ),
                            //       ),
                            //       RaisedButton(
                            //           onPressed: () async {
                            //             mystate(() {
                            //               quantity = quantity + 1;
                            //             });
                            //           },
                            //           child: Icon(
                            //             Icons.add,
                            //             color: Colors.white,
                            //             size: 16,
                            //           )),
                            //     ],
                            //   ),
                            // ),
                            // RaisedButton(
                            //   child: const Text('Hủy'),
                            //   onPressed: () => Navigator.pop(context),
                            // ),
                            // RaisedButton(
                            //   child: const Text('Xác nhận thanh toán'),
                            //   onPressed: () => Navigator.pop(context),
                            // )
                          ],
                        ),
                      );
                    });
                  },
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.075,
                child: Center(
                    child: BigText(
                  text: "buy".tr,
                  fontWeight: FontWeight.w900,
                )),
                decoration: BoxDecoration(
                    color: Color(0xFFFF9C00),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.white, Colors.redAccent, Colors.white],
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Container _slidableImages() {
    return Container(
      color: Colors.white,
      child: Container(
        height: 320,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Carousel(
            dotBgColor: Colors.transparent,
            showIndicator: true,
            dotSize: 5,
            dotSpacing: 15,
            boxFit: BoxFit.cover,
            images: [
              widget.data!.imagePath != null
                  ? CustomCacheImage(imageUrl: widget.data!.imagePath)
                  : Image.asset('assets/images/logo.png'),
              widget.data!.imagePath != null
                  ? CustomCacheImage(imageUrl: widget.data!.imagePath)
                  : Image.asset('assets/images/logo.png'),
              widget.data!.imagePath != null
                  ? CustomCacheImage(imageUrl: widget.data!.imagePath)
                  : Image.asset('assets/images/logo.png'),
            ]),
      ),
    );
  }
}
