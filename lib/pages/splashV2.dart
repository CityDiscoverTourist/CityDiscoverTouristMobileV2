import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:travel_hour/blocs/sign_in_bloc.dart';
import 'package:travel_hour/config/config.dart';
import 'package:travel_hour/pages/sign_in.dart';
import 'package:travel_hour/pages/home.dart';
import 'package:travel_hour/utils/next_screen.dart';

import '../controllers/login_controller.dart';

class SplashStart extends StatefulWidget {
  SplashStart({Key? key}) : super(key: key);

  _SplashStartState createState() => _SplashStartState();
}

class _SplashStartState extends State<SplashStart>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  // afterSplash() {
  //   var controller = Get.find<LoginController>();
  //   controller.getDataFromSp();
  //   controller.checkUserLoggedIn();
  // }

  // gotoHomePage() {
  //   final SignInBloc sb = context.read<SignInBloc>();
  //   if (sb.isSignedIn == true) {
  //     sb.getDataFromSp();
  //   }
  //   nextScreenReplace(context, HomePage());
  // }

  // gotoSignInPage() {
  //   nextScreenReplace(context, SignInPage());
  // }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _controller.repeat();
    // afterSplash();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
              child: Image(
                image: AssetImage(Config().splashIcon),
                height: 120,
                width: 120,
                fit: BoxFit.contain,
              )),
        ),
        Center(
          child: Text('City Discovery Tourist',style: TextStyle(fontSize: 16),),
        )
      ],
    ));
  }
}
