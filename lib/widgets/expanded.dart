import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';

class ExpandedWidget extends StatefulWidget {
  final String text;
  const ExpandedWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandedWidget> createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;
  @override
  void initState() {
    super.initState();
    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(151, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.length == ""
            ? 
            Html(
                data: widget.text,
                // customRender: {
                //     'flutter' : (RenderContext context, Widget child, attributes, _){
                //       return FlutterLogo(
                //         style: FlutterLogoStyle.horizontal,
                //         textColor: Colors.blue,
                //         size: 100.0,
                //       );
                //     }
                // },
                style: {
                  'html': Style(backgroundColor: Colors.white12),
                  'table': Style(backgroundColor: Colors.grey.shade200),
                  'td': Style(
                    backgroundColor: Colors.grey.shade400,
                    padding: EdgeInsets.all(10),
                  ),
                  'th': Style(padding: EdgeInsets.all(10), color: Colors.black),
                  'tr': Style(
                      backgroundColor: Colors.grey.shade300,
                      border: Border(
                          bottom: BorderSide(color: Colors.greenAccent))),
                },
                // onLinkTap: (url){
                //     print('Open the url $url......');
                // },
                // onImageTap: (img){
                //     print('Image $img');
                // },
                // onImageError: (exception, stacktrace){
                //     print(exception);
                // },
              )
            // Text(
            //     widget.text,
            //     textAlign: TextAlign.justify,
            //     style: TextStyle(
            //       fontFamily: 'RobotoMono',
            //       fontSize: 16,
            //     ),
            //   )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  // flag?  firstHalf:widget.text,
                  //   textAlign: TextAlign.justify,
                  //   style: TextStyle(
                  //     fontFamily: 'RobotoMono',
                  //     fontSize: 16,
                  //   ),
                  // ),
                  Html(
                data: flag?  firstHalf:widget.text,
                // customRender: {
                //     'flutter' : (RenderContext context, Widget child, attributes, _){
                //       return FlutterLogo(
                //         style: FlutterLogoStyle.horizontal,
                //         textColor: Colors.blue,
                //         size: 100.0,
                //       );
                //     }
                // },
                style: {
                  'html': Style(backgroundColor: Colors.white12),
                  'table': Style(backgroundColor: Colors.grey.shade200),
                  'td': Style(
                    backgroundColor: Colors.grey.shade400,
                    padding: EdgeInsets.all(10),
                  ),
                  'th': Style(padding: EdgeInsets.all(10), color: Colors.black),
                  'tr': Style(
                      backgroundColor: Colors.grey.shade300,
                      border: Border(
                          bottom: BorderSide(color: Colors.greenAccent))),
                },
                // onLinkTap: (url){
                //     print('Open the url $url......');
                // },
                // onImageTap: (img){
                //     print('Image $img');
                // },
                // onImageError: (exception, stacktrace){
                //     print(exception);
                // },
              ),
                  InkWell(
                    onTap: () {
                    setState(() {
                        flag = !flag;
                    });
                    },
                    child: Row(
                      children: [
                        Text(
                          "Show more",
                          style: TextStyle(color: (Colors.blueAccent)),
                        ),
                        Icon(
                        flag?  Icons.keyboard_arrow_down:Icons.keyboard_arrow_up,
                          color: (Colors.blueAccent),
                        )
                      ],
                    ),
                  )
                ],
              ));
  }
}
