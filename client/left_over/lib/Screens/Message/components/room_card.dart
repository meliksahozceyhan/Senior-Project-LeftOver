// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/Models/Product.dart';
import 'package:left_over/models/message/RoomModel.dart';

import '../../../constants.dart';

class RoomCard extends StatelessWidget {
  final RoomModel roomModel;
  final Function press;
  const RoomCard({
    Key key,
    this.roomModel,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        children: <Widget>[
          Material(
            child: Icon(
              Icons.account_circle_rounded,
              size: 50,
              color: darkBackgroundColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(25)),
            clipBehavior: Clip.hardEdge,
          ),
          Flexible(
              child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    roomModel.participant2.fullName,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                        color: bTextColorLight,
                        fontSize: 15),
                  ),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                )
              ],
            ),
          ))
        ],
      ),
      onPressed: press,
    );
  }
}
