import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:left_over/Screens/Message/components/message_card.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/User.dart';
import 'package:left_over/models/message/MessageModel.dart';
import 'package:left_over/models/message/RoomModel.dart';
import 'package:left_over/socket_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MessageDetail extends StatefulWidget {
  final RoomModel roomModel;
  const MessageDetail({Key key, this.roomModel}) : super(key: key);

  @override
  _MessageDetailState createState() =>
      _MessageDetailState(roomModel: roomModel);
}

class _MessageDetailState extends State<MessageDetail> {
  _MessageDetailState({this.roomModel}) : super();
  final RoomModel roomModel;
  String userId = "";
  User user = null;
  int messageCount = 20, page = 0, messagePerPage = 20;
  List<MessageModel> messages = [];
  SocketService socketService = SocketService();

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    listScrollController.addListener(_scrollListener);
    fetchMessagesOfRoom();
    getUserDetailsFromSharedPrefs();
    if (socketService.socket == null) {
      socketService.initialize();
    } else {
      socketService.socket.on("onNewMessage",
          (data) => onNewMessageReceived(MessageModel.fromJson(data)));
    }
    super.initState();
  }

  void getUserDetailsFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    userId = payload['id'];
    user = User.fromJson(payload);
  }

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        messageCount <= messages.length) {
      setState(() {
        messageCount += messageCount;
        page += 1;
        fetchMessagesOfRoom();
      });
    }
  }

  Future<void> fetchMessagesOfRoom() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers["Authorization"] = "Bearer " + token;

    var url = Uri.parse(dotenv.env['API_URL'] +
        "/message/getMessagesOfRoom?roomId=${roomModel.id}" +
        "&pageNumber=$page&messageCount=$messagePerPage");

    final response = await http.get(url, headers: headers);

    var responseJson = jsonDecode(response.body) as List;
    setState(() {
      messages = List<MessageModel>.from(
          responseJson.map((json) => MessageModel.fromJson(json)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          roomModel.participant2.fullName,
          style: const TextStyle(color: bTextColorLight),
        ),
        centerTitle: true,
        backgroundColor: bPrimaryColor,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[buildMessageList(), buildInput()],
          )
        ],
      ),
    );
  }

  Widget buildMessageList() {
    return Flexible(
        child: messages.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) =>
                    MessageCard(messageModel: messages[index], userId: userId),
                itemCount: messages.length,
                reverse: true,
                controller: listScrollController,
              )
            : const Center(
                child: Text(
                  'No Messages Here',
                  style: TextStyle(color: bTextColorLight),
                ),
              ));
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text);
                },
                style: const TextStyle(color: bPrimaryColor, fontSize: 15),
                controller: textEditingController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: kTextLightColor),
                ),
              ),
              margin: const EdgeInsets.all(15),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Material(
                child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => onSendMessage(textEditingController.text),
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
          border:
              Border(top: BorderSide(color: darkBackgroundColor, width: 0.5)),
          color: Colors.white),
    );
  }

  void onSendMessage(String content) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      setState(() {
        MessageModel temp = MessageModel.localMessage(
            content: content, isRead: false, from: user, to: roomModel);
        messages.add(temp);
        socketService.handleSendMessage(temp);
      });
    } else {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text(
            'Please Enter something to send.',
          ),
          backgroundColor: redCheck,
          action: SnackBarAction(
              label: 'Close',
              onPressed: scaffold.hideCurrentSnackBar,
              textColor: Colors.white),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void onNewMessageReceived(MessageModel messageModel) {
    setState(() {
      messages.add(messageModel);
    });

    socketService.handleMessageRead(messageModel);
  }
}
