import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:travel_hour/api/api.dart';
import 'package:travel_hour/common/customFullScreenDialog.dart';
import 'package:travel_hour/pages/chat.dart';

import '../models/chatmessage.dart';
import 'login_controller_V2.dart';

class ChatController extends GetxController {
  bool _isConnected = false;
  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  // List<ChatMessage> getMessages() => messages;
  late HubConnection _connection;
  String token = "";
  var conID = "".obs;

  bool getIsConnected() {
    return _isConnected;
  }

  @override
  void onInit() {
    // StartSocket();
    super.onInit();
  }

  void sendChatMessage(ChatMessage outgoingMessage) {
    _connection.connectionId;
    outgoingMessage.conId = conID.value;
    messages.add(outgoingMessage);
    print("connectionId on send:" + outgoingMessage.conId);
    post(Uri.parse(Api.baseUrl + "/support-channels/to-admin"),
            headers: {
              "Content-Type": "application/json",
              "Authorization":
                  "Bearer " + Get.find<LoginControllerV2>().jwtToken.value
            },
            body: jsonEncode(outgoingMessage))
        .then((response) {});
  }

  Future<void> StartSocket() async {
    // CustomFullScreenDialog.showDialog();
    final serverUrl = "https://citytourist.azurewebsites.net" + "/chat";
    _connection = HubConnectionBuilder().withUrl(serverUrl).build();
    print("Server url: " + serverUrl);
    _connection.serverTimeoutInMilliseconds = 10 * 60 * 60 * 1000;
    _connection.keepAliveIntervalInMilliseconds = 10 * 60 * 60 * 1000;
    await _connection.start();
    _isConnected = true;
    print("ConnectionID:" + _connection.connectionId.toString());
    conID.value = _connection.connectionId!;
    // CustomFullScreenDialog.cancelDialog();
    _connection.on("AdminSendMessageToCustomer", (data) {
      Map<String, dynamic> map = json.decode(jsonEncode(data![0]));
      print(map);
      if (map['conId'] == conID.value) {
        messages.add(ChatMessage.fromJson(map));
        messages.refresh();
      } else {
        messages.add(ChatMessage.fromJson(map));
        messages.refresh();
        print("Not Same" + map['conId']);
      }
    });
  }

  Future<void> StopSocket() async {
    _isConnected = false;
    _connection.stop();
  }
}
