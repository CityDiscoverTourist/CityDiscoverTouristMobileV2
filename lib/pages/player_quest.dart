import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/pages/payment_detail.dart';
import 'package:travel_hour/pages/start_play.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/custom_cache_image.dart';
import 'package:travel_hour/widgets/small_text.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';

class PlayerQuestPage extends StatelessWidget {
  const PlayerQuestPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 100000;
    var controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
      backgroundColor: Colors.redAccent,
      title: BigText(text: 'My Quest',color: Colors.white,fontWeight: FontWeight.w700,),),
      body: ListView.builder(
        itemCount: controller.questList.length,
        itemBuilder: (_, _currentIndex) {
          return Row(
            children: [
              Icon(Icons.payment),
              Expanded(
                child: InkWell(
                  onTap: (){print('CARD TAP');Get.to(PaymentDetail());},
                  child: Card(
                    child: ListTile(
                      title: BigText(
                          text: controller.questList[_currentIndex].title),
                      subtitle: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CountdownTimer(
                            endTime: endTime,
                            widgetBuilder: (_, CurrentRemainingTime? time) {
                              if (time == null) {
                                return Text('Availble');
                              }
                              return BigText(
                                text:
                                    ' ${time.days}d:${time.hours}h:${time.min}m:${time.sec}s',
                                color: Colors.green,
                              );
                            },
                          ),
                        ],
                      ),
                      trailing: InkWell(
                        child: const Icon(Icons.play_arrow),
                        onTap: () {print('ICON TAP');Get.to(StartPage());},
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add,),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.blueGrey.shade50,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      BigText(text: 'EnterCode'),
                      TextField(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: const Text('Close '),
                            onPressed: () => Navigator.pop(context),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                            child: const Text('Submit'),
                            onPressed: () => {},
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
