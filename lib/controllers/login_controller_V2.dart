import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:travel_hour/common/customFullScreenDialog.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/models/customer.dart';

import '../routes/app_routes.dart';
import '../services/login_service.dart';

class LoginControllerV2 extends GetxController {
  var jwtToken = "".obs;
  late GoogleSignIn googleSign;
  var isSignIn = false.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String deviceId = ""; //*
  //  var homeController=Get.find<HomeController>();
  late Customer sp;

  @override
  void onInit()  {
    super.onInit();
   
  }

  @override
  void onReady() async{
    super.onReady();
    print("[Login V2]-L28-ONREADY :");
     googleSign = GoogleSignIn();
       ever(isSignIn, handleAuthStateChanged);

    isSignIn.value =  firebaseAuth.currentUser != null;
    firebaseAuth.authStateChanges().listen((event) {
      isSignIn.value = event != null;
    });

  
  }

  void handleAuthStateChanged(isLoggedIn) async {
    print("[LoginController V2]-L162-DeviceID:" + deviceId);
    if (isLoggedIn) {
      print("[LoginControllerV2]-L164: ");
      sp = await LoginService().apiCheckLogin(
          await firebaseAuth.currentUser!.getIdToken(), deviceId);
      if ( sp != null){
    //  Get.put(HomeController(),permanent: true);
        Get.offAllNamed(KWelcomeScreen, arguments: firebaseAuth.currentUser);

      }
      else {
        await googleSign.disconnect();
        await firebaseAuth.signOut();
      }
    } else {
      Get.offAllNamed(KLoginScreen);
    }
  }
  void login() async {
    CustomFullScreenDialog.showDialog();
    GoogleSignInAccount? googleSignInAccount =
        await googleSign.signIn();
    if (googleSignInAccount == null) {
      CustomFullScreenDialog.cancelDialog();
    } else {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      print(googleSignInAuthentication.idToken);
      // print("Tesst");
      await firebaseAuth.signInWithCredential(oAuthCredential);
      CustomFullScreenDialog.cancelDialog();
    }
  }
    void logout() async {
    await googleSign.disconnect();
    await firebaseAuth.signOut();
  }
}
