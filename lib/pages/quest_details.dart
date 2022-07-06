import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:travel_hour/pages/start_play.dart';

import '../controllers/home_controller.dart';
import '../models/quest.dart';
import '../widgets/custom_cache_image.dart';
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
    var myController = Get.find<HomeController>();
    return Scaffold(
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
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: <Widget>[
                    //     Icon(
                    //       Icons.attach_money_outlined,
                    //       size: 20,
                    //       color: Colors.grey,
                    //     ),
                    //     Expanded(
                    //         child: Text(
                    //       widget.data!.price.toString(),
                    //       style: TextStyle(
                    //         fontSize: 26,
                    //         color: Colors.green[600],
                    //       ),
                    //       maxLines: 2,
                    //       overflow: TextOverflow.ellipsis,
                    //     )),

                    //   ],
                    // ),
                    Text(widget.data!.title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.6,
                            wordSpacing: 1,
                            color: Colors.grey[800])),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      height: 3,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    // RatingBarIndicator(
                    //   rating: 2.75,
                    //   itemBuilder: (context, index) => Icon(
                    //     Icons.star,
                    //     color: Colors.amber,
                    //   ),
                    //   itemCount: 5,
                    //   itemSize: 20.0,
                    //   direction: Axis.horizontal,
                    // ),
                   
                    Row(
                      children: <Widget>[
                        // LoveCount(
                        //     collectionName: collectionName,
                        //     timestamp: widget.data!.timestamp),
                        Text('⭐ 4.7',style: TextStyle(fontSize: 18),),
                        SizedBox(
                          width: 50,
                        ),
                        Icon(
                          Feather.message_circle,
                          color: Colors.grey,
                          size: 20,
                        ),
                         Text('47',style: TextStyle(fontSize: 18),),
                        // CommentCount(
                        //     collectionName: collectionName,
                        //     timestamp: widget.data!.timestamp)
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          widget.data!.description,
                          style:
                              TextStyle(fontFamily: 'RobotoMono', fontSize: 16),
                        )),
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

              // Padding(
              //   padding: EdgeInsets.only(left: 20, right: 0, bottom: 40),
              //   child: OtherPlaces(
              //     stateName: widget.data!.state,
              //     timestamp: widget.data!.timestamp,
              //   ),
              // )
              SizedBox(height: MediaQuery.of(context).size.height * 0.1)
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.075,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(widget.data!.price.toString() + ' VNĐ',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.green[600],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: ElevatedButton(
                      onPressed: () {Get.to(StartPage());},
                      child: Text('MUA', style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(
                            left: 40.0, top: 16.0, bottom: 16.0, right: 40.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ))
      ]),
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
              CustomCacheImage(imageUrl: widget.data!.imagePath),
              CustomCacheImage(imageUrl: widget.data!.imagePath),
              CustomCacheImage(imageUrl: widget.data!.imagePath),
            ]),
      ),
    );
  }
}
