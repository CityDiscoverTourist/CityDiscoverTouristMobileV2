import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/questpurchased_controller.dart';
import 'package:travel_hour/pages/home.dart';
import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/small_text.dart';

import '../config/colors.dart';
import '../controllers/play_controllerV2.dart';

class RatingQuest extends StatelessWidget {
  const RatingQuest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: 'FeedBack',
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              color: Colors.white,
              child: ListView(children: [
                Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: BigText(
                          text: "Rate Your Experience",
                          size: 36,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: SmallText(
                          text: "Are your Satisfied with Service?",
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: RatingBar.builder(
                        initialRating: 3,
                        itemSize: 50,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: AppColors.mainColor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    Divider(
                      height: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: BigText(
                          text: "Tell us what can be Improved?",
                          size: 14,
                          fontWeight: FontWeight.w800,
                        )),
                  ],
                ),
                Row(
                  children: [
                    exampleComment("Quest Rat Hay"),
                    exampleComment("Quest Rat Hay"),
                  ],
                ),
                Row(
                  children: [
                   exampleComment("Quest Rat Hay"),
                    exampleComment("Quest Rat Hay"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 40),
                    hintText: "Tell us on how can we improve...",
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Colors.teal,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.comment,
                      color: Colors.black,
                    ),
                  ),
                )
              ]),
            ),
            InkWell(
              onTap: () {
                Get.delete<PlayControllerV2>();
                Get.delete<QuestPurchasedController>();
                Get.toNamed(KWelcomeScreen);
              },
              child: Container(
                width: double.infinity,
                height: 50,
                color: AppColors.mainColor,
                child: Center(
                    child: BigText(
                  text: "Submit",
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container exampleComment(String commentContent) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SmallText(
        text: commentContent,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[300]),
    );
  }
}
