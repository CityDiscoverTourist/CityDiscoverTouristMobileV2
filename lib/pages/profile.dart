import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_hour/blocs/notification_bloc.dart';
import 'package:travel_hour/blocs/sign_in_bloc.dart';
import 'package:travel_hour/config/config.dart';
import 'package:travel_hour/controllers/login_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/pages/edit_profile.dart';
import 'package:travel_hour/pages/notifications.dart';
import 'package:travel_hour/pages/sign_in.dart';
import 'package:travel_hour/pages/sign_inV2.dart';
import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/services/app_service.dart';
import 'package:travel_hour/utils/next_screen.dart';
import 'package:travel_hour/widgets/language.dart';

import '../controllers/home_controller.dart';
// import 'package:easy_localization/easy_localization.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  // var data = Get.arguments;

  //CUONGNHT EDITCODE
  //CALL LOGIN CONTROLLER TO GET CUSTOMER'S INFORMATION

  openAboutDialog() {
    // final sb = context.read<SignInBloc>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AboutDialog(
            applicationName: Config().appName,
            applicationIcon: Image(
              image: AssetImage(Config().splashIcon),
              height: 30,
              width: 30,
            ),
            applicationVersion: "1.0",
          );
        });
  }

  TextStyle _textStyle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey[900]);
  int _currentIndex = 3;
  PageController _pageController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<IconData> iconList = [
    Feather.home,
    Feather.list,
    Feather.bookmark,
    Feather.user
  ];

  void onTabTapped(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(index,
        curve: Curves.easeIn, duration: Duration(milliseconds: 300));
  }

  Future _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      _pageController.animateToPage(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      await SystemChannels.platform
          .invokeMethod<void>('SystemNavigator.pop', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final sb = context.watch<SignInBloc>();
    // LoginController controller = LoginController();
    return Scaffold(
        appBar: AppBar(
          title: Text('profile'.tr),
          centerTitle: false,
          actions: [
            IconButton(
                icon: Icon(LineIcons.bell, size: 25),
                onPressed: () => nextScreen(context, NotificationsPage()))
          ],
        ),
        // key: scaffoldKey,
        // bottomNavigationBar: AnimatedBottomNavigationBar(
        //   icons: iconList,
        //   activeColor: Theme.of(context).primaryColor,
        //   gapLocation: GapLocation.none,
        //   activeIndex: _currentIndex,
        //   inactiveColor: Colors.grey[500],
        //   splashColor: Theme.of(context).primaryColor,
        //   iconSize: 22,
        //   onTap: (index) => onTabTapped(index),
        // ),
        body: ListView(
          controller: _pageController,
          padding: EdgeInsets.fromLTRB(15, 20, 15, 50),
          children: [
            // controller.isSignedIn == false ? GuestUserUI() :
            UserUI(),

            Text(
              "general setting".tr,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            SizedBox(
              height: 15,
            ),
            ListTile(
              title: Text('get notifications'.tr, style: _textStyle),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(Feather.bell, size: 20, color: Colors.white),
              ),
              // trailing: Switch(
              //     activeColor: Theme.of(context).primaryColor,
              //     value: context.watch<NotificationBloc>().subscribed!,
              //     onChanged: (bool) {
              //       context.read<NotificationBloc>().fcmSubscribe(bool);
              //     }),
            ),
            Divider(
              height: 5,
            ),

            ListTile(
              title: Text('language'.tr, style: _textStyle),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(Feather.globe, size: 20, color: Colors.white),
              ),
              trailing: Icon(
                Feather.chevron_right,
                size: 20,
              ),
              onTap: () => nextScreenPopup(context, LanguagePopup()),
            ),
            Divider(
              height: 5,
            ),

            ListTile(
              title: Text('contact us'.tr, style: _textStyle),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(Feather.mail, size: 20, color: Colors.white),
              ),
              trailing: Icon(
                Feather.chevron_right,
                size: 20,
              ),
              onTap: () async => await AppService().openEmailSupport(context),
            ),
            Divider(
              height: 5,
            ),

            ListTile(
              title: Text('rate this app'.tr, style: _textStyle),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(Feather.star, size: 20, color: Colors.white),
              ),
              trailing: Icon(
                Feather.chevron_right,
                size: 20,
              ),
              onTap: () async => AppService().launchAppReview(context),
            ),

            Divider(
              height: 5,
            ),

            ListTile(
              title: Text('privacy policy'.tr, style: _textStyle),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(Feather.lock, size: 20, color: Colors.white),
              ),
              trailing: Icon(
                Feather.chevron_right,
                size: 20,
              ),
              onTap: () => AppService()
                  .openLinkWithCustomTab(context, Config().privacyPolicyUrl),
            ),
            Divider(
              height: 5,
            ),

            ListTile(
              title: Text('about us'.tr, style: _textStyle),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(Feather.info, size: 20, color: Colors.white),
              ),
              trailing: Icon(
                Feather.chevron_right,
                size: 20,
              ),
              onTap: () => AppService()
                  .openLinkWithCustomTab(context, Config().yourWebsiteUrl),
            ),

            Divider(
              height: 10,
            ),

            ListTile(
              title: Text('facebook'.tr, style: _textStyle),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(Feather.facebook, size: 20, color: Colors.white),
              ),
              trailing: Icon(
                Feather.chevron_right,
                size: 20,
              ),
              onTap: () =>
                  AppService().openLink(context, Config().facebookPageUrl),
            ),

            Divider(
              height: 10,
            ),

            ListTile(
              title: Text('youtube'.tr, style: _textStyle),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(Feather.youtube, size: 20, color: Colors.white),
              ),
              trailing: Icon(
                Feather.chevron_right,
                size: 20,
              ),
              onTap: () =>
                  AppService().openLink(context, Config().youtubeChannelUrl),
            ),

            // Divider(height: 10,),

            // ListTile(
            //   title: Text('buy now', style: _textStyle,).tr(),
            //   subtitle: Text('buy now subtitle').tr(),
            //   leading: Container(
            //     height: 30,
            //     width: 30,
            //     decoration: BoxDecoration(
            //       color: Colors.blueGrey,
            //       borderRadius: BorderRadius.circular(5)
            //     ),
            //     child: Icon(Feather.shopping_cart, size: 20, color: Colors.white),
            //   ),
            //   trailing: Icon(Feather.chevron_right, size: 20,),
            //   onTap: ()async{
            //     String _url = 'https://codecanyon.net/item/flutter-travel-app-ui-kit-template-travel-hour/24958845';
            //     AppService().openLinkWithCustomTab(context, _url);
            //   },
            // ),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class GuestUserUI extends StatelessWidget {
  const GuestUserUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey[900]);

    return Column(
      children: [
        ListTile(
          title: Text(
            'login'.tr,
            style: _textStyle,
          ),
          leading: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(5)),
            child: Icon(Feather.user, size: 20, color: Colors.white),
          ),
          trailing: Icon(
            Feather.chevron_right,
            size: 20,
          ),
          onTap: () => nextScreenPopup(context, LoginScreen()),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class UserUI extends StatelessWidget {
  const UserUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final sb = context.watch<SignInBloc>();
    var data = Get.arguments;
    var controller = Get.find<LoginControllerV2>();
    String image =
        "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000";
    // if (controller.sp.imagePath != null) {
    //   image = controller.sp.imagePath!;
    // }
    // controller.getDataFromSp();
    TextStyle _textStyle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey[900]);
    return Column(
      children: [
        Container(
          height: 200,
          child: Column(
            children: [
              CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: CachedNetworkImageProvider(image)),
              // CircleAvatar(
              //     radius: 60,
              //     backgroundColor: Colors.grey[300],
              //     backgroundImage: CachedNetworkImageProvider(
              //         controller.sp.imagePath.toString())),
              SizedBox(
                height: 10,
              ),
              Text(
                controller.sp.userName.toString(),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.6,
                    wordSpacing: 2),
              )
            ],
          ),
        ),
        ListTile(
          title: Text(
            controller.sp.email.toString(),
            style: _textStyle,
          ),
          leading: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(5)),
            child: Icon(Feather.mail, size: 20, color: Colors.white),
          ),
        ),
        Divider(
          height: 5,
        ),
        // ListTile(
        //   title: Text(
        //     "sb.joiningDate!",
        //     style: _textStyle,
        //   ),
        //   leading: Container(
        //     height: 30,
        //     width: 30,
        //     decoration: BoxDecoration(
        //         color: Colors.green, borderRadius: BorderRadius.circular(5)),
        //     child: Icon(LineIcons.timesCircle, size: 20, color: Colors.white),
        //   ),
        // ),
        // Divider(
        //   height: 5,
        // ),
        ListTile(
            title: Text(
              'edit profile'.tr,
              style: _textStyle,
            ),
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(Feather.edit_3, size: 20, color: Colors.white),
            ),
            trailing: Icon(
              Feather.chevron_right,
              size: 20,
            ),
            onTap: () => Get.to(EditProfile(
                name: controller.sp.userName.toString(),
                address: controller.sp.address.toString(),
                gender: controller.sp.gender,
                imageUrl: image))),
        Divider(
          height: 5,
        ),
        ListTile(
          title: Text(
            'logout'.tr,
            style: _textStyle,
          ),
          leading: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5)),
            child: Icon(Feather.log_out, size: 20, color: Colors.white),
          ),
          trailing: Icon(
            Feather.chevron_right,
            size: 20,
          ),
          onTap: () => openLogoutDialog(context),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }

  void openLogoutDialog(context) {
    LoginControllerV2 controller = Get.find<LoginControllerV2>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('logout title'.tr),
            actions: [
              TextButton(
                child: Text('no'.tr),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text('yes'.tr),
                onPressed: () {
                  Navigator.pop(context);
                  controller.logout();
                },
              )
            ],
          );
        });
  }
}
