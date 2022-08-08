import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controllers/play_controllerV2.dart';
import '../models/purchased_quest.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {}
    controller!.pauseCamera();
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    if (controller != null && mounted) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(flex: 7, child: _buildQrView(context)),
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (result != null)
                      Text('${result!.code}')
                    else
                      Text('scan qr code'.tr),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Container(
                        //   margin: const EdgeInsets.all(8),
                        //   child: ElevatedButton(
                        //       onPressed: () async {
                        //         await controller?.toggleFlash();
                        //         setState(() {});
                        //       },
                        //       child: FutureBuilder(
                        //         future: controller?.getFlashStatus(),
                        //         builder: (context, snapshot) {
                        //           return Text('Flash: ${snapshot.data}');
                        //         },
                        //       )),
                        // ),
                        // Container(
                        //   margin: const EdgeInsets.all(8),
                        //   child: ElevatedButton(
                        //       onPressed: () async {
                        //         await controller?.flipCamera();
                        //         setState(() {});
                        //       },
                        //       child: FutureBuilder(
                        //         future: controller?.getCameraInfo(),
                        //         builder: (context, snapshot) {
                        //           if (snapshot.data != null) {
                        //             return Text(
                        //                 'Camera facing ${describeEnum(snapshot.data!)}');
                        //           } else {
                        //             return const Text('loading');
                        //           }
                        //         },
                        //       )),
                        // )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                result = null;
                              });
                            },
                            child: Text('reset'.tr,
                                style: TextStyle(fontSize: 10)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            onPressed: () async {
                              // await controller?.pauseCamera();
                              String? code = result?.code;
                              showAlertDialog(context, code!);
                            },
                            child:
                                Text('ok'.tr, style: TextStyle(fontSize: 10)),
                          ),
                        ),
                        // Container(
                        //   margin: const EdgeInsets.all(8),
                        //   child: ElevatedButton(
                        //     onPressed: () async {
                        //       await controller?.resumeCamera();
                        //     },
                        //     child: const Text('resume',
                        //         style: TextStyle(fontSize: 20)),
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  showAlertDialog(BuildContext context, String code) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("ok".tr),
      onPressed: () async {
        PlayControllerV2 controller = new PlayControllerV2();
        PurchasedQuest? purchasedQuest =
            await controller.getPuQuestById(result!.code);
        if (purchasedQuest != null) {
          Get.put(PlayControllerV2()).pQuest = purchasedQuest;
          Navigator.of(context).pop();
        } else {
          Get.snackbar(
              'play code not exist or expired'.tr, 'please try again'.tr,
              duration: Duration(seconds: 2),
              backgroundColor: Colors.black,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              icon: Icon(
                Icons.error,
                color: Colors.red,
              ));
          Navigator.of(context).pop();
        }

        // Get.to(RulePage(
        //   pQuest: pQuest,
        // ));
        //  vao trang huong dan
        // Navigator.of(context).pop();
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("cancel".tr),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("cofirm".tr),
      content: Text(
          "quests that have entered the game cannot be reused. do you want to confirm?"
              .tr),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
