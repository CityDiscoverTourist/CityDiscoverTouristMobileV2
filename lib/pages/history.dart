import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/quest.dart';
import 'package:travel_hour/utils/empty.dart';
import 'package:travel_hour/utils/list_card.dart';
import 'package:travel_hour/utils/loading_cards.dart';

import '../controllers/home_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with AutomaticKeepAliveClientMixin {
  var controller = Get.find<HomeController>();
  List<Quest> list = Get.find<HomeController>().hisQuestList;
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(milliseconds: 3000)).then((_) async => list =
    //     (await controller
    //         .fetchPlayingHistory(Get.find<LoginControllerV2>().sp.id))!);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final SignInBloc sb = context.watch<SignInBloc>();
    // var controller = Get.find<HomeController>();

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('playing history'.tr),
            centerTitle: false,
            titleSpacing: 20,
            // bottom: TabBar(
            //     labelPadding: EdgeInsets.only(left: 10, right: 10),
            //     indicatorColor: Theme.of(context).primaryColor,
            //     isScrollable: false,
            //     labelColor: Colors.black,
            //     unselectedLabelColor: Colors.grey[500],
            //     indicatorWeight: 0,
            //     indicatorSize: TabBarIndicatorSize.tab,
            //     labelStyle: TextStyle(
            //         fontFamily: 'Manrope',
            //         fontSize: 15,
            //         fontWeight: FontWeight.w600),
            //     indicator: MD2Indicator(
            //       indicatorHeight: 3,
            //       indicatorSize: MD2IndicatorSize.normal,
            //       indicatorColor: Theme.of(context).primaryColor,
            //     ),
            //     tabs: [
            //       Tab(
            //         child: Container(
            //           padding: EdgeInsets.only(left: 15, right: 15),
            //           alignment: Alignment.centerLeft,
            //           child: Text('saved places'.tr),
            //         ),
            //       ),
            //       Tab(
            //         child: Container(
            //           padding: EdgeInsets.only(left: 15, right: 15),
            //           alignment: Alignment.centerLeft,
            //           child: Text('saved blogs'.tr),
            //         ),
            //       )
            //     ]),
          ),
          // body: TabBarView(children: <Widget>[
          //   BookmarkedPlaces(),
          //   BookmarkedBlogs(),
          // ]),
          body: RefreshIndicator(
              child: Container(
                child: FutureBuilder(
                  // future: context.watch<BookmarkBloc>().getPlaceData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (list.isNotEmpty) {
                      if (list.length == 0)
                        return EmptyPage(
                          icon: Feather.bookmark,
                          message: 'no playing history found'.tr,
                          message1: ''.tr,
                        );
                      else
                        return ListView.separated(
                          padding: EdgeInsets.all(5),
                          itemCount: list.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return ListCard(
                              d: list[index],
                              tag: "bookmark$index",
                              color: Colors.white,
                            );
                          },
                        );
                    }
                    return ListView.separated(
                      padding: EdgeInsets.all(15),
                      itemCount: 5,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return LoadingCard(height: 150);
                      },
                    );
                  },
                ),
              ),
              onRefresh: _onRefresh)
          // Container(
          //   child: FutureBuilder(
          //     // future: context.watch<BookmarkBloc>().getPlaceData(),
          //     builder: (BuildContext context, AsyncSnapshot snapshot) {
          //       if (list.isNotEmpty) {
          //         if (list.length == 0)
          //           return EmptyPage(
          //             icon: Feather.bookmark,
          //             message: 'no playing history found'.tr,
          //             message1: ''.tr,
          //           );
          //         else
          //           return ListView.separated(
          //             padding: EdgeInsets.all(5),
          //             itemCount: list.length,
          //             separatorBuilder: (context, index) => SizedBox(
          //               height: 5,
          //             ),
          //             itemBuilder: (BuildContext context, int index) {
          //               return ListCard(
          //                 d: list[index],
          //                 tag: "bookmark$index",
          //                 color: Colors.white,
          //               );
          //             },
          //           );
          //       }
          //       return ListView.separated(
          //         padding: EdgeInsets.all(15),
          //         itemCount: 5,
          //         separatorBuilder: (BuildContext context, int index) => SizedBox(
          //           height: 10,
          //         ),
          //         itemBuilder: (BuildContext context, int index) {
          //           return LoadingCard(height: 150);
          //         },
          //       );
          //     },
          //   ),
          // ),
          ),
    );
  }

  @override
  bool get wantKeepAlive => true;
  Future<void> _onRefresh() async {
    Get.find<HomeController>()
        .fetchPlayingHistory(Get.find<LoginControllerV2>().sp.id);
  }
}

// class BookmarkedPlaces extends StatefulWidget {
//   const BookmarkedPlaces({Key? key}) : super(key: key);

//   @override
//   _BookmarkedPlacesState createState() => _BookmarkedPlacesState();
// }

// class _BookmarkedPlacesState extends State<BookmarkedPlaces>
//     with AutomaticKeepAliveClientMixin {
//   final String collectionName = 'hotels';
//   final String type = 'bookmarked_hotels';
//   var controller = Get.find<HomeController>();

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Container(
//       child: FutureBuilder(
//         // future: context.watch<BookmarkBloc>().getPlaceData(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (list.isNotEmpty) {
//             if (controller.questList.length == 0)
//               return EmptyPage(
//                 icon: Feather.bookmark,
//                 message: 'no playing history found'.tr,
//                 message1: ''.tr,
//               );
//             else
//               return ListView.separated(
//                 padding: EdgeInsets.all(5),
//                 itemCount: controller.questList.length,
//                 separatorBuilder: (context, index) => SizedBox(
//                   height: 5,
//                 ),
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListCard(
//                     d: controller.questList[index],
//                     tag: "bookmark$index",
//                     color: Colors.white,
//                   );
//                 },
//               );
//           }
//           return ListView.separated(
//             padding: EdgeInsets.all(15),
//             itemCount: 5,
//             separatorBuilder: (BuildContext context, int index) => SizedBox(
//               height: 10,
//             ),
//             itemBuilder: (BuildContext context, int index) {
//               return LoadingCard(height: 150);
//             },
//           );
//         },
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }

// class BookmarkedBlogs extends StatefulWidget {
//   const BookmarkedBlogs({Key? key}) : super(key: key);

//   @override
//   _BookmarkedBlogsState createState() => _BookmarkedBlogsState();
// }

// class _BookmarkedBlogsState extends State<BookmarkedBlogs>
//     with AutomaticKeepAliveClientMixin {
//   final String collectionName = 'blogs';
//   final String type = 'bookmarked_blogs';
//   var controller = Get.find<HomeController>();

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Container(
//       child: FutureBuilder(
//         // future: context.watch<BookmarkBloc>().getBlogData(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (controller.questList.isNotEmpty) {
//             if (controller.questList.length == 0)
//               return EmptyPage(
//                 icon: Feather.bookmark,
//                 message: 'no blogs found'.tr,
//                 message1: 'save your favourite blogs here'.tr,
//               );
//             else
//               return ListView.separated(
//                 padding: EdgeInsets.all(15),
//                 itemCount: controller.questList.length,
//                 separatorBuilder: (context, index) => SizedBox(
//                   height: 15,
//                 ),
//                 itemBuilder: (BuildContext context, int index) {
//                   return _BlogList(data: controller.questList[index]);
//                 },
//               );
//           }
//           return ListView.separated(
//             padding: EdgeInsets.all(15),
//             itemCount: 5,
//             separatorBuilder: (BuildContext context, int index) => SizedBox(
//               height: 10,
//             ),
//             itemBuilder: (BuildContext context, int index) {
//               return LoadingCard(height: 120);
//             },
//           );
//         },
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }

// class _BlogList extends StatelessWidget {
//   final Quest? data;
//   const _BlogList({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Container(
//         height: 120,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(3)),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(3),
//               child: Hero(
//                   tag: 'bookmark${data!.areaId}',
//                   child: Container(
//                     width: 140,
//                     child: CustomCacheImage(imageUrl: data!.imagePath),
//                   )),
//             ),
//             Flexible(
//               child: Container(
//                 margin:
//                     EdgeInsets.only(left: 15, top: 15, right: 10, bottom: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       data!.title,
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Spacer(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(CupertinoIcons.time,
//                                 size: 16, color: Colors.grey),
//                             SizedBox(
//                               width: 3,
//                             ),
//                             Text('create day',
//                                 // data!.createdDate.toString(),
//                                 style: TextStyle(
//                                     fontSize: 13, color: Colors.grey)),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.favorite, size: 16, color: Colors.grey),
//                             SizedBox(
//                               width: 3,
//                             ),
//                             Text(data!.areaId.toString(),
//                                 style: TextStyle(
//                                     fontSize: 13, color: Colors.grey)),
//                           ],
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       onTap: () {
//         // nextScreen(context,
//         //     BlogDetails(blogData: con, tag: 'bookmark${data!.timestamp}'));
//       },
//     );
//   }
// }
