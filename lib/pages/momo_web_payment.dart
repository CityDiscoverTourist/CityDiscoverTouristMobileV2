// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
// import 'package:flutterappmomo/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../config/colors.dart';
// import 'package:flutterappmomo/main.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

// String selectedUrl = 'https://flutter.io';

final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();

class MoMoWebView extends StatefulWidget {
  const MoMoWebView({Key? key, required this.url}) : super(key: key);

  final String? url;
  static bool status = false;

  @override
  _MoMoWebView createState() => _MoMoWebView();
}

class _MoMoWebView extends State<MoMoWebView> {
  // Instance of WebView plugin
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  // On destroy stream
  late StreamSubscription _onDestroy;

  // On urlChanged stream
  late StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  late StreamSubscription<WebViewStateChanged> _onStateChanged;

  late StreamSubscription<WebViewHttpError> _onHttpError;

  late StreamSubscription<double> _onProgressChanged;

  late StreamSubscription<double> _onScrollYChanged;

  late StreamSubscription<double> _onScrollXChanged;

  // final _urlCtrl = TextEditingController(text: selectedUrl);

  final _codeCtrl = TextEditingController(text: 'window.navigator.userAgent');

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _history = [];

  @override
  void initState() {
    super.initState();

    flutterWebViewPlugin.close();

    // _urlCtrl.addListener(() {
    //   selectedUrl = _urlCtrl.text;
    // });

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
      if (mounted) {
        // Actions like show a info toast.
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(const SnackBar(content: Text('Webview Destroyed')));
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          if (url.contains("momo://?action=")) {
            // MyAppState().setStatus("ok");
            launchUrlString(url, mode: LaunchMode.externalApplication);
            // MyApp().paymentStatus = "ok";
            flutterWebViewPlugin.close();
            Navigator.pop(context);
          }
          if (url.contains("citydiscovery.tech")) {
            // MyAppState().setStatus("false");
            // PaymentWidgetState().UpdateStatus("cancel");
            flutterWebViewPlugin.close();
            Navigator.pop(context);
            // Navigator.pop(context);
          }
          _history.add('onUrlChanged: $url');
        });
      }
    });

    _onProgressChanged =
        flutterWebViewPlugin.onProgressChanged.listen((double progress) {
      if (mounted) {
        setState(() {
          _history.add('onProgressChanged: $progress');
        });
      }
    });

    _onScrollYChanged =
        flutterWebViewPlugin.onScrollYChanged.listen((double y) {
      if (mounted) {
        setState(() {
          _history.add('Scroll in Y Direction: $y');
        });
      }
    });

    _onScrollXChanged =
        flutterWebViewPlugin.onScrollXChanged.listen((double x) {
      if (mounted) {
        setState(() {
          _history.add('Scroll in X Direction: $x');
        });
      }
    });

    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      // if (state.type == WebViewState.abortLoad) {
      //   canLaunch(state.url).then((val) => val ? launch(state.url) : null);
      // }
      // if (state.type == WebViewState.abortLoad) {
      //   canLaunch(state.url).then((val) => val ? launch(state.url) : null);
      // }
      // if (mounted) {
      //   setState(() {
      //     _history.add('onStateChanged: ${state.type} ${state.url}');
      //   });
      // }
    });

    _onHttpError =
        flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
      if (mounted) {
        setState(() {
          _history.add('onHttpError: ${error.code} ${error.url}');
        });
      }
    });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    _onProgressChanged.cancel();
    _onScrollXChanged.cancel();
    _onScrollYChanged.cancel();

    flutterWebViewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
        ),
        body: WebviewScaffold(
          url: widget.url!,
          // javascriptChannels: jsChannels,

          mediaPlaybackRequiresUserGesture: false,
          // appBar: AppBar(
          //   title: const Text('Widget WebView'),
          // ),
          withZoom: true,
          withLocalStorage: true,
          allowFileURLs: true,
          // hidden: true,
          initialChild: Container(
            color: AppColors.mainColor,
            child: Center(
              child: Text('waiting loading data...'.tr),
            ),
          ),
          // bottomNavigationBar: BottomAppBar(
          //   child: Row(
          //     children: <Widget>[
          //       IconButton(
          //         icon: const Icon(Icons.arrow_back_ios),
          //         onPressed: () {
          //           flutterWebViewPlugin.goBack();
          //         },
          //       ),
          //       IconButton(
          //         icon: const Icon(Icons.arrow_forward_ios),
          //         onPressed: () {
          //           flutterWebViewPlugin.goForward();
          //         },
          //       ),
          //       IconButton(
          //         icon: const Icon(Icons.autorenew),
          //         onPressed: () {
          //           flutterWebViewPlugin.reload();
          //         },
          //       ),
          //     ],
          //   ),
          // ),
        ));
  }
}
