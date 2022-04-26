import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:left_over/Screens/Message/components/message_detail.dart';
import 'package:left_over/Screens/Message/components/room_card.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/message/RoomModel.dart';
import 'package:left_over/socket_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class MessageBody extends StatefulWidget {
  const MessageBody({Key key}) : super(key: key);

  @override
  _MessageBodyState createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  List<RoomModel> rooms = [];

  SocketService socketService = SocketService();

  void fetchRoomsOfUser() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    var userId = payload['id'];

    Map<String, String> headers = new Map<String, String>();
    headers["Authorization"] = "Bearer " + token;

    var url = Uri.parse(
        dotenv.env['API_URL'] + "/room/getRoomsOfUser?userId=$userId");

    final response = await http.get(url, headers: headers);

    var responseJson = jsonDecode(response.body) as List;
    setState(() {
      rooms = List<RoomModel>.from(
          responseJson.map((json) => RoomModel.fromJson(json)));
    });
  }

  @override
  void initState() {
    fetchRoomsOfUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: kDefaultPaddin, horizontal: kDefaultPaddin),
        child: rooms.length > 0
            ? ListView.builder(
                itemBuilder: (context, index) => RoomCard(
                    roomModel: rooms[index],
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MessageDetail(
                                  roomModel: rooms[index],
                                )))),
                itemCount: rooms.length,
              )
            : Center(child: Text("No users")));
  }
}
