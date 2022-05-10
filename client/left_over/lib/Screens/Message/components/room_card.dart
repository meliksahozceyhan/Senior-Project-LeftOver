// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/Models/Product.dart';
import 'package:left_over/models/User.dart';
import 'package:left_over/models/message/RoomModel.dart';

import '../../../constants.dart';

class RoomCard extends StatelessWidget {
  final RoomModel roomModel;
  final Function press;
  final User user;

  const RoomCard({Key key, this.roomModel, this.press, this.user})
      : super(key: key);

  User getRoomOwner() {
    return user.id == roomModel.participant1.id
        ? roomModel.participant2
        : roomModel.participant1;
  }

  @override
  Widget build(BuildContext context) {
    User roomOwner = getRoomOwner();
    return TextButton(
      child: Row(
        children: <Widget>[
          Material(
            child: CircleAvatar(
                backgroundImage: roomOwner.profileImage != null
                    ? NetworkImage(
                        dotenv.env['API_URL'] + "/image/" + roomOwner.profileImage)
                    : AssetImage('assets/images/profile_avatar.jpg')),
            borderRadius: BorderRadius.all(Radius.circular(25)),
            clipBehavior: Clip.hardEdge,
          ),
          Flexible(
              child: Container(
            child: Row(
              children: <Widget>[
                Text(
                  user.id == roomModel.participant1.id
                      ? roomModel.participant2.fullName
                      : roomModel.participant1.fullName,
                  // ignore: prefer_const_constructors
                  style: TextStyle(color: bTextColorLight, fontSize: 15),
                ),
                Spacer(),
                roomModel.messageCount != "0"
                    ? Badge(
                        badgeContent: Text(roomModel.messageCount),
                      )
                    : Text("")
              ],
            ),
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          ))
        ],
      ),
      onPressed: press,
    );
  }
}
