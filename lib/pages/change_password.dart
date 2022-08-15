import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import 'package:travel_hour/blocs/sign_in_bloc.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/services/app_service.dart';
import 'package:travel_hour/utils/snacbar.dart';

import '../config/colors.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    Key? key,
  }) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool loading = false;
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var oldPassCtrl = TextEditingController();
  var newPassCtrl = TextEditingController();
  var conPassCtrl = TextEditingController();

  Future handleUpdateData() async {
    // final sb = context.read<SignInBloc>();
    // await AppService().checkInternet().then((hasInternet) async {
    //   if (hasInternet == false) {
    //     openSnacbar(scaffoldKey, 'no internet'.tr);
    //   } else {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() => loading = true);
      bool check = await Get.find<LoginControllerV2>()
          .changePassword(oldPassCtrl.text, newPassCtrl.text);
      if (check == true) {
        setState(() => loading = false);
      }
      setState(() => loading = false);
      // imageFile == null
      //     ? await sb
      //         .updateUserProfile(nameCtrl.text, imageUrl!)
      //         .then((value) {
      //         openSnacbar(scaffoldKey, 'updated successfully'.tr());
      //         setState(() => loading = false);
      //       })
      //     : await uploadPicture().then((value) =>
      //         sb.updateUserProfile(nameCtrl.text, imageUrl!).then((_) {
      //           openSnacbar(scaffoldKey, 'updated successfully'.tr());
      //           setState(() => loading = false);
      //         }));
    }
    //   }
    // }
    // );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('change password'.tr),
          backgroundColor: AppColors.mainColor,
        ),
        body: ListView(
          padding: const EdgeInsets.all(25),
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Form(key: formKey, child: _getFormUI()),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => AppColors.mainColor),
                    textStyle: MaterialStateProperty.resolveWith(
                        (states) => TextStyle(color: Colors.white))),
                child: loading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : Text(
                        'cofirm'.tr,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                onPressed: () {
                  handleUpdateData();
                },
              ),
            ),
          ],
        ));
  }

  Widget _getFormUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          // keyboardType: TextInputType.emailAddress,
          autofocus: false,
          obscureText: _obscureText,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'enter old password'.tr,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                semanticLabel: _obscureText ? 'show password' : 'hide password',
              ),
            ),
          ),
          controller: oldPassCtrl,
          validator: (value) {
            if (value!.length == 0) return "old password can't be empty";
            return null;
          },
          // onSaved: (String? value) {
          //   userName = value!;
          // },
        ),
        new SizedBox(height: 20.0),
        new TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          obscureText: _obscureText2,
          decoration: InputDecoration(
            errorMaxLines: 2,
            hintText: 'enter new password'.tr,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText2 = !_obscureText2;
                });
              },
              child: Icon(
                _obscureText2 ? Icons.visibility : Icons.visibility_off,
                semanticLabel:
                    _obscureText2 ? 'show password' : 'hide password',
              ),
            ),
          ),
          controller: newPassCtrl,
          validator: (value) {
            String patttern =
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
            RegExp regExp = new RegExp(patttern);
            if (value == "") {
              return "password is required".tr;
            } else if (value!.length < 6) {
              return "password must minimum six characters".tr;
            } else if (!regExp.hasMatch(value)) {
              return "password at least one uppercase letter, one lowercase letter, one specical character and one number"
                  .tr;
            }
            return null;
          },
          // onSaved: (String? value) {
          //   userName = value!;
          // },
        ),
        new SizedBox(height: 20.0),
        new TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          obscureText: _obscureText3,
          decoration: InputDecoration(
            hintText: 'cofirm new password'.tr,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText3 = !_obscureText3;
                });
              },
              child: Icon(
                _obscureText3 ? Icons.visibility : Icons.visibility_off,
                semanticLabel:
                    _obscureText3 ? 'show password' : 'hide password',
              ),
            ),
          ),
          controller: conPassCtrl,
          validator: (value) {
            if (value != newPassCtrl.text) {
              return "new password and cofirm password must be the same!".tr;
            }
            return null;
          },
          // onSaved: (String? value) {
          //   userName = value!;
          // },
        ),
      ],
    );
  }
}
