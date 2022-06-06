
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../controllers/home_controller.dart';

import '../models/quest_type.dart';
import '../pages/more_quests.dart';
import '../pages/quest_type.dart';
import 'custom_cache_image.dart';




class PopularQuests extends StatelessWidget {
  PopularQuests({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final pb = context.watch<PopularPlacesBloc>();
     var controller = Get.find<HomeController>();
    

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, top: 15, right: 10),
          child: Row(children: <Widget>[
            Text('Các thể loại', style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: Colors.grey[900],
              wordSpacing: 1,
              letterSpacing: -0.6
              ),
            ).tr(),
            Spacer(),
            IconButton(icon: Icon(Icons.arrow_forward),
              onPressed: () =>
              
                 Get.to(QuestTypePage())
              
              //  nextScreen(context, MorePlacesPage(title: 'popular', color: Colors.grey[800],)),            
            )
          ],),
        ),
        

        Container(
          height: 245,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 15, right: 15),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.questTypeList.isEmpty ? 3 : controller.questTypeList.length,
            itemBuilder: (BuildContext context, int index) {
              // if(pb.data.isEmpty) return LoadingPopularPlacesCard();
              return _ItemList(q: controller.questTypeList[index],);
              //return LoadingCard1();
           },
          ),
        )
        
        
      ],
    );
  }
}


class _ItemList extends StatelessWidget {
  final QuestType q;
  const _ItemList({Key? key, required this.q}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
          child: Container(
                margin: EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 5),
                width: MediaQuery.of(context).size.width * 0.40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)
                  
                ),
                child: Stack(
                   children: [
                     Hero(
                       tag: 'popular${q.id}',
                        child: ClipRRect(
                        
                        borderRadius: BorderRadius.circular(10),
                        child: CustomCacheImage(imageUrl: q.imagePath)
                      //  child: Image.network(q.imagePath,fit: BoxFit.fill,),
                       ),
                     ),
                     Align(
                       alignment: Alignment.bottomLeft,
                       child: Padding(
                         padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                         child: Text(q.name, 
                         maxLines: 2,
                         style: TextStyle(
                           fontSize: 16,
                           fontWeight: FontWeight.w500,
                           color: Colors.white
                         ),),
                       ),
                     ),

                     Align(
                       alignment: Alignment.topRight,
                       child: Padding(
                         padding: const EdgeInsets.only(top: 15, right: 15,),
                         child: Container(
                           padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20),
                             color: Colors.grey[600]!.withOpacity(0.5),
                           ),
                           child: Row(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               Icon(LineIcons.heart, size: 16, color: Colors.white),
                               SizedBox(width: 5,),
                               Text(q.name, style: TextStyle(
                                 fontSize: 12,
                                 color: Colors.white
                               ),)
                             ],
                           ),
                         )
                       ),
                     )

                   ],
                ),
                
              ),

              onTap: () =>Get.to(MoreQuestPage(title: q.name, color: Colors.grey))
    );
  }
}


