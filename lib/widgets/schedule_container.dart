import 'package:flutter/material.dart';
import 'package:travel_hour/widgets/big_text.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:timxe/data/booking.dart';
import 'package:url_launcher/url_launcher.dart';

class ScheduleContainer extends StatelessWidget {
  // final Booking scheduleItem;
  final String contentRule;
  final int ruleNum;
  ScheduleContainer(this.contentRule,this.ruleNum);
  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Padding( 
        padding: const EdgeInsets.only(left: 20, right: 20),
         child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.only(left: 8),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              )),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [BigText(text:contentRule)],)
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: CircleAvatar(radius: 25,backgroundColor: Colors.amber,child: Text("Rule ${ruleNum}",style: TextStyle(fontWeight: FontWeight.bold),)),
      )
    ]);
  }
}
