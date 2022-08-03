import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller_V2.dart';

class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';

  @override
  State<StatefulWidget> createState() {
    return new _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  bool _obscureText = true;
  bool _obscureText2 = true;
  var nameCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  var conPassCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
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
          // onSaved: (String? value) {
          //   userName = value!;
          // },
        ),
        new SizedBox(height: 20.0),
        new TextFormField(
          autofocus: false,
          controller: passCtrl,
          obscureText: _obscureText,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'password'.tr,
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
          // onSaved: (String? value) {
          //   _password = value!;
          // },
        ),
        new SizedBox(height: 20.0),
        new TextFormField(
          autofocus: false,
          controller: conPassCtrl,
          obscureText: _obscureText2,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'cofirm password'.tr,
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
          validator: (value) {
            if (value == "") {
              return "cofirm password is required".tr;
            } else if (value != passCtrl.text) {
              return "password and cofirm password must be the same!".tr;
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
            child: Text('register'.tr, style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  _sendToServer() {
    if (_key.currentState!.validate()) {
      var controller = Get.find<LoginControllerV2>();
      controller.register(nameCtrl.text, passCtrl.text);
    } else {
      ///validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
