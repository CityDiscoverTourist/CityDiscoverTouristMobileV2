import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:travel_hour/controllers/chat_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/chatmessage.dart';
// import 'package:flutter_chat_app/models/message_model.dart';
// import 'package:flutter_chat_app/models/user_model.dart';

class ChatScreen extends StatefulWidget {
  // final User user;

  // ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> messagesList = List.empty(growable: true);
  var messageCtr = TextEditingController();
  var chatController = Get.find<ChatController>();
  @override
  void initState() {
    // Get.put(ChatController());
    if (chatController.conID.value == "") {
      chatController.StartSocket();
    }
    super.initState();
  }

  // _chatBubble(Message message, bool isMe, bool isSameUser) {4

  _chatBubble(String message, bool isMe, bool isSameUser) {
    if (isMe) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                // message.text,
                message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      // message.time,
                      '12:20',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage('asset/img/'),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                // message.text,
                message,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      // child: CircleAvatar(
                      //   radius: 15,
                      //   // backgroundImage: AssetImage(message.sender.imageUrl),
                      //   backgroundColor: Colors.amber,
                      // ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // Text(
                    //   // message.time,
                    //   'acc',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     color: Colors.black45,
                    //   ),
                    // ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.photo),
          //   iconSize: 25,
          //   color: Theme.of(context).primaryColor,
          //   onPressed: () {},
          // ),
          Expanded(
            child: TextField(
              controller: messageCtr,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              ChatMessage chatMessage = new ChatMessage(
                message: messageCtr.text,
                user: Get.find<LoginControllerV2>().sp.userName,
                conId: "",
              );
              chatController.sendChatMessage(chatMessage);
              setState(() {
                messageCtr.text="";
              });
              // controller.messages.add(chatMessage);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int prevUserId;

    var check = true;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                  text: 'Admin',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
              TextSpan(text: '\n'),
              check == true
                  ? TextSpan(
                      text: 'Online',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : TextSpan(
                      text: 'Offline',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    )
            ],
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: GetX<ChatController>(builder: (chatController) {
            return ListView.builder(
              reverse: false,
              padding: EdgeInsets.all(20),
              itemCount: chatController.messages.length,
              itemBuilder: (BuildContext context, int index) {
                // final Message message = messages[index];
                //  final bool isMe = message.sender.id == currentUser.id;
                // final bool isSameUser = prevUserId == message.sender.id;
                // prevUserId = message.sender.id;

                final ChatMessage message = chatController.messages[index];
                final bool isSameUser;
                final bool isMe;
                if (message.user == Get.find<LoginControllerV2>().sp.userName) {
                  isSameUser = true;
                  isMe = true;
                } else {
                  isSameUser = false;
                  isMe = false;
                }
                // setState(() {});
                return _chatBubble(message.message, isMe, isSameUser);
              },
            );
          })),
          _sendMessageArea(),
        ],
      ),
    );
  }
}