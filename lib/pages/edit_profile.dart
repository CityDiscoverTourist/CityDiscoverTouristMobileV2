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

class EditProfile extends StatefulWidget {
  final String? name;
  final String? imageUrl;
  final String? address;
  final bool? gender;

  EditProfile(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.address,
      required this.gender})
      : super(key: key);

  @override
  _EditProfileState createState() =>
      _EditProfileState(this.name, this.imageUrl);
}

class _EditProfileState extends State<EditProfile> {
  _EditProfileState(this.name, this.imageUrl);

  String? address;
  String? name;
  String? imageUrl;

  File? imageFile;
  String? fileName;
  bool loading = false;
  List gender = ["Male", "Female"];
  String? select;
  bool? updateGender;

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var nameCtrl = TextEditingController();
  var addressCtrl = TextEditingController();

  Future pickImage() async {
    final _imagePicker = ImagePicker();
    var imagepicked = await _imagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);

    if (imagepicked != null) {
      setState(() {
        imageFile = File(imagepicked.path);
        fileName = (imageFile!.path);
      });
    } else {
      print('No image has is selected!');
    }
  }

  // Future uploadPicture() async {
  //   // final SignInBloc sb = context.read<SignInBloc>();
  //   // Reference storageReference =
  //   //     FirebaseStorage.instance.ref().child('Profile Pictures/${sb.uid}');
  //   UploadTask uploadTask = storageReference.putFile(imageFile!);

  //   await uploadTask.whenComplete(() async {
  //     var _url = await storageReference.getDownloadURL();
  //     var _imageUrl = _url.toString();
  //     setState(() {
  //       imageUrl = _imageUrl;
  //     });
  //   });
  // }

  Future handleUpdateData() async {
    // final sb = context.read<SignInBloc>();
    // await AppService().checkInternet().then((hasInternet) async {
    //   if (hasInternet == false) {
    //     openSnacbar(scaffoldKey, 'no internet'.tr);
    //   } else {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() => loading = true);
      if (imageFile != null) {
        bool check = await Get.find<LoginControllerV2>()
            .editProfile(addressCtrl.text, updateGender, imageFile);
        if (check) {
          Get.snackbar("success".tr, 'update profile success'.tr,
              duration: Duration(seconds: 5),
              backgroundColor: Colors.black,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              icon: Icon(
                Icons.error,
                color: Colors.green,
              ));
          setState(() => loading = false);
        }
      } else {
        bool check = await Get.find<LoginControllerV2>()
            .editProfile(addressCtrl.text, updateGender, null);
        if (check) {
          Get.snackbar("success".tr, 'update profile success'.tr,
              duration: Duration(seconds: 5),
              backgroundColor: Colors.black,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              icon: Icon(
                Icons.error,
                color: Colors.green,
              ));
          setState(() {
            loading = false;
          });
        } else {
          Get.snackbar("error".tr, 'update profile error'.tr,
              duration: Duration(seconds: 5),
              backgroundColor: Colors.black,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              icon: Icon(
                Icons.error,
                color: Colors.red,
              ));
        }
      }
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
    nameCtrl.text = widget.name!;
    if (widget.address != null) {
      print("Lay dc address");
      addressCtrl.text = widget.address!;
    }
    updateGender = widget.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('edit profile'.tr),
        ),
        body: ListView(
          padding: const EdgeInsets.all(25),
          children: <Widget>[
            InkWell(
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey[300],
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey[800]!),
                      color: Colors.grey[500],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: (imageFile == null
                              ? CachedNetworkImageProvider(imageUrl!)
                              : FileImage(imageFile!)) as ImageProvider<Object>,
                          fit: BoxFit.cover)),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.edit,
                        size: 30,
                        color: Colors.black,
                      )),
                ),
              ),
              onTap: () {
                pickImage();
              },
            ),
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
                        (states) => Theme.of(context).primaryColor),
                    textStyle: MaterialStateProperty.resolveWith(
                        (states) => TextStyle(color: Colors.white))),
                child: loading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : Text(
                        'update profile'.tr,
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
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          enabled: false,
          decoration: InputDecoration(
            hintText: 'enter new name'.tr,
            fillColor: Colors.grey,
            filled: true,
          ),
          controller: nameCtrl,
          validator: (value) {
            if (value!.length == 0) return "Name can't be empty";
            return null;
          },
          // onSaved: (String? value) {
          //   userName = value!;
          // },
        ),
        new SizedBox(height: 20.0),
        new TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'enter new address'.tr,
          ),
          controller: addressCtrl,
          validator: (value) {
            if (value!.length == 0) return "Address can't be empty";
            return null;
          },
          // onSaved: (String? value) {
          //   userName = value!;
          // },
        ),
        new SizedBox(height: 20.0),
        GenderPickerWithImage(
          showOtherGender: false,
          verticalAlignedText: true,
          selectedGender: widget.gender == true ? Gender.Male : Gender.Female,
          selectedGenderTextStyle:
              TextStyle(color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
          unSelectedGenderTextStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
          onChanged: (Gender? gender) {
            print(gender.toString());
            if (gender.toString() == "Gender.Female") {
              updateGender = false;
            } else {
              updateGender = true;
            }
          },
          equallyAligned: true,
          animationDuration: Duration(milliseconds: 300),
          isCircular: false,
          // default : true,
          opacityOfGradient: 0.4,
          padding: const EdgeInsets.all(3),
          size: 75, //default : 40
        )
      ],
    );
  }
}
