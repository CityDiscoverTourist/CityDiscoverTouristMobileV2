import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/routes/app_pages.dart';
import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/utils/tranlations.dart';

import 'app.dart';
import 'bindings/home_binding.dart';
import 'bindings/login_binding.dart';
import 'controllers/login_controller.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.dark));
  // WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  // runApp(EasyLocalization(
  //   supportedLocales: [Locale('en'), Locale('es'), Locale('ar')],
  //   path: 'assets/translations',
  //   fallbackLocale: Locale('en'),
  //   startLocale: Locale('en'),
  //   useOnlyLangCode: true,
  //   child: MyApp(),
  // ));
  // LoginBinding().dependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(LoginController(), permanent: true);
  Get.put(LoginControllerV2(), permanent: true);
  Get.put(HomeController(), permanent: true);
  // LoginController controller = new LoginController();
  // controller.checkUserLoggedIn();

  runApp(GetMaterialApp(
    translations: Translation(),
    locale: Locale('vn'),
    fallbackLocale: Locale('vn'),
    // It is not mandatory to use named routes, but dynamic urls are interesting.
    initialRoute: KSplashScreen,
    defaultTransition: Transition.native,
    //  translations: MyTranslations(),
    getPages: AppPages.getPages(),
    initialBinding: LoginBinding(),
    //Hello fen
    //HOWAREU
  ));
  // var controller = Get.find<LoginController>();
  // controller.checkUserLoggedIn();
}


// import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:provider/provider.dart';
// import 'package:travel_hour/blocs/comments_bloc.dart';
// import 'package:travel_hour/blocs/sign_in_bloc.dart';
// import 'package:travel_hour/models/comment.dart';
// import 'package:travel_hour/services/app_service.dart';
// import 'package:travel_hour/utils/dialog.dart';
// import 'package:travel_hour/utils/empty.dart';
// import 'package:travel_hour/utils/loading_cards.dart';
// import 'package:travel_hour/utils/sign_in_dialog.dart';
// import 'package:travel_hour/utils/toast.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:travel_hour/widgets/custom_cache_image.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: CommentsPage(),
//     );
//   }
// }

// class CommentsPage extends StatefulWidget {
//   // final String collectionName;
//   // final String? timestamp;
//   // const CommentsPage(
//   //     {Key? key, required this.collectionName, required this.timestamp})
//   //     : super(key: key);

//   @override
//   _CommentsPageState createState() => _CommentsPageState();
// }

// class _CommentsPageState extends State<CommentsPage> {
//   // final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   // ScrollController? controller;
//   // DocumentSnapshot? _lastVisible;
//   // late bool _isLoading;
//   // List<DocumentSnapshot> _snap = [];
//   // List<Comment> _data = [];
//   // final scaffoldKey = GlobalKey<ScaffoldState>();
//   var textCtrl = TextEditingController();
//   // bool? _hasData;

//   @override
//   void initState() {
//     // controller = new ScrollController()..addListener(_scrollListener);
//     super.initState();
//     // _isLoading = true;
//     // _getData();
//   }

//   // Future<Null> _getData() async {
//   //   setState(() => _hasData = true);
//   //   await context.read<CommentsBloc>().getFlagList();
//   //   QuerySnapshot data;
//   //   if (_lastVisible == null)
//   //     data = await firestore
//   //         .collection('${widget.collectionName}/${widget.timestamp}/comments')
//   //         .orderBy('timestamp', descending: true)
//   //         .limit(10)
//   //         .get();
//   //   else
//   //     data = await firestore
//   //         .collection('${widget.collectionName}/${widget.timestamp}/comments')
//   //         .orderBy('timestamp', descending: true)
//   //         .startAfter([_lastVisible!['timestamp']])
//   //         .limit(10)
//   //         .get();

//   //   if (data.docs.length > 0) {
//   //     _lastVisible = data.docs[data.docs.length - 1];
//   //     if (mounted) {
//   //       setState(() {
//   //         _isLoading = false;
//   //         _snap.addAll(data.docs);
//   //         _data = _snap.map((e) => Comment.fromFirestore(e)).toList();
//   //         print('blog reviews : ${_data.length}');
//   //       });
//   //     }
//   //   } else {
//   //     if (_lastVisible == null) {
//   //       setState(() {
//   //         _isLoading = false;
//   //         _hasData = false;
//   //         print('no items');
//   //       });
//   //     } else {
//   //       setState(() {
//   //         _isLoading = false;
//   //         _hasData = true;
//   //         print('no more items');
//   //       });
//   //     }
//   //   }
//   //   return null;
//   // }

//   @override
//   void dispose() {
//     // controller!.removeListener(_scrollListener);
//     super.dispose();
//   }

//   // void _scrollListener() {
//   //   if (!_isLoading) {
//   //     if (controller!.position.pixels == controller!.position.maxScrollExtent) {
//   //       setState(() => _isLoading = true);
//   //       _getData();
//   //     }
//   //   }
//   // }

//   // openPopupDialog(Comment d) {
//   //   final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);

//   //   showDialog(
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return SimpleDialog(
//   //           contentPadding: EdgeInsets.all(20),
//   //           children: [

//   //             context.watch<CommentsBloc>().flagList.contains(d.timestamp)
//   //             ? Container()
//   //             : ListTile(

//   //               title: Text('flag this comment').tr(),
//   //               leading: Icon(Icons.flag),
//   //               onTap: ()async{
//   //                 await context.read<CommentsBloc>().addToFlagList(context, d.timestamp)
//   //                 .then((value) => onRefreshData());
//   //                 Navigator.pop(context);
//   //               },
//   //             ),
//   //             context.watch<CommentsBloc>().flagList.contains(d.timestamp)
//   //             ? ListTile(
//   //               title: Text('unflag this comment').tr(),
//   //               leading: Icon(Icons.flag_outlined),
//   //               onTap: ()async{
//   //                 await context.read<CommentsBloc>().removeFromFlagList(context, d.timestamp)
//   //                 .then((value) => onRefreshData());
//   //                 Navigator.pop(context);
//   //               },
//   //             )
//   //             : Container(),

//   //             ListTile(
//   //               title: Text('report').tr(),
//   //               leading: Icon(Icons.report),
//   //               onTap: (){
//   //                 handleReport(d);
//   //               },
//   //             ),
//   //             sb.uid == d.uid ?
//   //             ListTile(
//   //               title: Text('delete').tr(),
//   //               leading: Icon(Icons.delete),
//   //               onTap: () => handleDelete1(d),
//   //             )
//   //             : Container()
//   //           ],
//   //         );
//   //       });
//   // }

//   // Future handleReport (Comment d)async{
//   //   final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
//   //   if(sb.isSignedIn == true){
//   //     await context.read<CommentsBloc>().reportComment(widget.collectionName, widget.timestamp, d.uid, d.timestamp);
//   //     Navigator.pop(context);
//   //     openDialog(context, 'report-info'.tr(), "report-info1".tr());

//   //   }else{
//   //     Navigator.pop(context);
//   //     openDialog(context, 'report-guest'.tr(), 'report-guest1'.tr());
//   //   }
//   // }

//   // Future handleDelete1(Comment d) async {
//   //   final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
//   //   await AppService().checkInternet().then((hasInternet)async{
//   //     if(hasInternet == false){
//   //       Navigator.pop(context);
//   //       openToast(context, 'no internet'.tr());
//   //     }else{
//   //       await context.read<CommentsBloc>().deleteComment(widget.collectionName, widget.timestamp, sb.uid, d.timestamp)
//   //       .then((value) => openToast(context, 'Deleted Successfully!'));
//   //       onRefreshData();
//   //       Navigator.pop(context);
//   //     }
//   //   });
//   // }

//   // Future handleSubmit() async {
//   //   final SignInBloc sb = context.read<SignInBloc>();
//   //   if (sb.guestUser == true) {
//   //     openSignInDialog(context);
//   //   }else{
//   //     if (textCtrl.text.isEmpty) {
//   //       print('Comment is empty');
//   //     } else {
//   //       await AppService().checkInternet().then((hasInternet){
//   //         if(hasInternet == false){
//   //           openToast(context, 'no internet'.tr());
//   //         }else{
//   //           context.read<CommentsBloc>().saveNewComment(widget.collectionName, widget.timestamp, textCtrl.text);
//   //           onRefreshData();
//   //           textCtrl.clear();
//   //           FocusScope.of(context).requestFocus(new FocusNode());
//   //         }
//   //       });
//   //     }
//   //   }
//   // }

//   // onRefreshData() {
//   //   setState(() {
//   //     _isLoading = true;
//   //     _snap.clear();
//   //     _data.clear();
//   //     _lastVisible = null;
//   //   });
//   //   _getData();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         title: Text("Answer").tr(),
//         titleSpacing: 0,
//         actions: [
//           IconButton(
//               icon: Icon(
//                 Feather.help_circle,
//                 size: 22,
//               ),
//               onPressed: () => null)
//         ],
//       ),
//       body: Column(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 // Stack(
//                 //   children: <Widget>[
//                 //     // widget.tag == null
//                 //     //     ? _slidableImages()
//                 //     //     :
//                 //     Positioned(
//                 //       top: 50,
//                 //       right: 0,
//                 //       child: Row(
//                 //         children: <Widget>[
//                 //           // LoveCount(
//                 //           //     collectionName: collectionName,
//                 //           //     timestamp: widget.data!.timestamp),
//                 //           Icon(
//                 //             Feather.share_2,
//                 //             color: Colors.white,
//                 //             size: 25,
//                 //           ),
//                 //           SizedBox(
//                 //             width: 30,
//                 //           ),
//                 //           Icon(
//                 //             Feather.heart,
//                 //             color: Colors.white,
//                 //             size: 25,
//                 //           ),
//                 //           SizedBox(
//                 //             width: 20,
//                 //           ),
//                 //           // CommentCount(
//                 //           //     collectionName: collectionName,
//                 //           //     timestamp: widget.data!.timestamp)
//                 //         ],
//                 //       ),
//                 //     )
//                 //   ],
//                 // ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       top: 20, bottom: 8, left: 20, right: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.start,
//                       //   children: <Widget>[
//                       //     Icon(
//                       //       Icons.attach_money_outlined,
//                       //       size: 20,
//                       //       color: Colors.grey,
//                       //     ),
//                       //     Expanded(
//                       //         child: Text(
//                       //       widget.data!.price.toString(),
//                       //       style: TextStyle(
//                       //         fontSize: 26,
//                       //         color: Colors.green[600],
//                       //       ),
//                       //       maxLines: 2,
//                       //       overflow: TextOverflow.ellipsis,
//                       //     )),

//                       //   ],
//                       // ),
//                       // Text("widget.data!.title",
//                       //     style: TextStyle(
//                       //         fontSize: 20,
//                       //         fontWeight: FontWeight.w900,
//                       //         letterSpacing: -0.6,
//                       //         wordSpacing: 1,
//                       //         color: Colors.grey[800])),
//                       // Container(
//                       //   margin: EdgeInsets.only(top: 8, bottom: 8),
//                       //   height: 3,
//                       //   width: 150,
//                       //   decoration: BoxDecoration(
//                       //       color: Theme.of(context).primaryColor,
//                       //       borderRadius: BorderRadius.circular(40)),
//                       // ),
//                       Padding(
//                           padding: EdgeInsets.all(30),
//                           child: Text(
//                             "widget.data!.description",
//                             style: TextStyle(
//                                 fontFamily: 'RobotoMono', fontSize: 16),
//                           )),
//                     ],
//                   ),
//                 ),

//                 // HtmlBodyWidget(
//                 //   content: widget.data!.description,
//                 //   isIframeVideoEnabled: true,
//                 //   isVideoEnabled: true,
//                 //   isimageEnabled: true,
//                 //   fontSize: 17,
//                 // ),

//                 // Padding(
//                 //   padding: EdgeInsets.only(left: 20, right: 0, bottom: 40),
//                 //   child: OtherPlaces(
//                 //     stateName: widget.data!.state,
//                 //     timestamp: widget.data!.timestamp,
//                 //   ),
//                 // )
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.1)
//               ],
//             ),
//           ),
//           Divider(
//             height: 1,
//             color: Colors.black26,
//           ),
//           SafeArea(
//             child: Container(
//               height: 65,
//               padding: EdgeInsets.only(top: 8, bottom: 10, right: 20, left: 20),
//               width: double.infinity,
//               color: Colors.white,
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(25)),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     errorStyle: TextStyle(fontSize: 0),
//                     contentPadding:
//                         EdgeInsets.only(left: 15, top: 10, right: 5),
//                     border: InputBorder.none,
//                     hintText: 'write a answer'.tr(),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         Icons.send,
//                         color: Colors.grey[700],
//                         size: 20,
//                       ),
//                       onPressed: () {
//                         // handleSubmit();
//                       },
//                     ),
//                   ),
//                   controller: textCtrl,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget reviewList(Comment d) {
//   //   return Container(
//   //       padding: EdgeInsets.only(top: 10, bottom: 10),
//   //       decoration: BoxDecoration(
//   //           color: Colors.white,
//   //           border: Border.all(color: Colors.grey[300]!),
//   //           borderRadius: BorderRadius.circular(5)),
//   //       child: ListTile(
//   //         leading: CircleAvatar(
//   //             radius: 25,
//   //             backgroundColor: Colors.grey[200],
//   //             backgroundImage: CachedNetworkImageProvider(d.imageUrl!)),
//   //         title: Row(
//   //           children: <Widget>[
//   //             Text(
//   //               d.name!,
//   //               style: TextStyle(
//   //                   color: Colors.black,
//   //                   fontSize: 13,
//   //                   fontWeight: FontWeight.w700),
//   //             ),
//   //             SizedBox(
//   //               width: 10,
//   //             ),
//   //             Text(d.date!,
//   //                 style: TextStyle(
//   //                     color: Colors.grey[500],
//   //                     fontSize: 11,
//   //                     fontWeight: FontWeight.w500)),
//   //           ],
//   //         ),
//   //         subtitle:
//   //             // context.read<CommentsBloc>().flagList.contains(d.timestamp)

//   //             // ? Text('comment flagged').tr()
//   //             // :
//   //             Text(
//   //           "d.comment!",
//   //           style: TextStyle(
//   //               fontSize: 15,
//   //               color: Colors.black54,
//   //               fontWeight: FontWeight.w500),
//   //         ),
//   //         onLongPress: () {
//   //           // openPopupDialog(d);
//   //         },
//   //       ));
//   // }
// }
