import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/pages/register.dart';

import '../config/colors.dart';

class UserLoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  State<StatefulWidget> createState() {
    return new _UserLoginPageState();
  }
}

class _UserLoginPageState extends State<UserLoginPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String userName = "";
  String _password = "";
  bool _obscureText = true;
  var nameCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  var forgotPassCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: new Center(
        child: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(20.0),
            child: Center(
              child: new Form(
                key: _key,
                child: _getFormUI(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFormUI() {
    return new Column(
      children: <Widget>[
        Icon(
          Icons.person,
          color: Colors.lightBlue,
          size: 100.0,
        ),
        new SizedBox(height: 50.0),
        new TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          controller: nameCtrl,
          decoration: InputDecoration(
            hintText: 'email'.tr,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: (value) {
            String pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp = new RegExp(pattern);
            if (value!.isEmpty) {
              return "email is required".tr;
            } else if (!regExp.hasMatch(value)) {
              return "invalid email".tr;
            } else {
              return null;
            }
          },
          onSaved: (String? value) {
            userName = value!;
          },
        ),
        new SizedBox(height: 20.0),
        new TextFormField(
          autofocus: false,
          controller: passCtrl,
          obscureText: _obscureText,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'password'.tr,
            errorMaxLines: 2,
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
          validator: (value) {
            String patttern =
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
            RegExp regExp = new RegExp(patttern);
            if (value == "") {
              return "password is required".tr;
            } else if (value!.length < 8) {
              return "password must minimum six characters".tr;
            } else if (!regExp.hasMatch(value)) {
              return "password at least one uppercase letter, one lowercase letter, one specical character and one number"
                  .tr;
            }
            return null;
          },
        ),
        new SizedBox(height: 15.0),
        new Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: _sendToServer,
            padding: EdgeInsets.all(12),
            color: Colors.lightBlueAccent,
            child: Text('log in'.tr, style: TextStyle(color: Colors.white)),
          ),
        ),
        new FlatButton(
          child: Text(
            'forgot password?'.tr,
            style: TextStyle(color: Colors.black54),
          ),
          onPressed: _showForgotPasswordDialog,
        ),
        new FlatButton(
          onPressed: _sendToRegisterPage,
          child: Text('not a member? sign up now'.tr,
              style: TextStyle(color: Colors.black54)),
        ),
      ],
    );
  }

  _sendToRegisterPage() {
    ///Go to register page
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  _sendToServer() {
    if (_key.currentState!.validate()) {
      var controller = Get.find<LoginControllerV2>();
      controller.loginUsernamePassword(nameCtrl.text, passCtrl.text);
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  Future<Null> _showForgotPasswordDialog() async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('please enter your email'.tr),
            contentPadding: EdgeInsets.all(5.0),
            content: new TextField(
              decoration: new InputDecoration(hintText: "email".tr),
              onChanged: (String value) {
                userName = value;
              },
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("cofirm".tr),
                onPressed: () async {
                  var controller = Get.find<LoginControllerV2>();
                  controller.forgotPassword(forgotPassCtrl.text);
                  Navigator.pop(context);
                },
              ),
              new FlatButton(
                child: new Text("cancel".tr),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }
}
