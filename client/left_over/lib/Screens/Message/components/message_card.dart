import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/message/MessageModel.dart';

class MessageCard extends StatelessWidget {
  final MessageModel messageModel;
  final String userId;
  const MessageCard({Key key, this.messageModel, this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (messageModel.from.id == userId) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
              messageModel.content,
              style: TextStyle(color: kPrimaryLightColor),
            ),
            padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/2-20, 10, 0, 10),
            width: MediaQuery.of(context).size.width/2,
            decoration: BoxDecoration(
                color: blueBlockColor, borderRadius: BorderRadius.circular(8)),
          )
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
              messageModel.content,
              style: TextStyle(color: Colors.white),
            ),
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),

            width: MediaQuery.of(context).size.width/2,
            decoration: BoxDecoration(
                color: lightBlueBlockColor, borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.fromLTRB(0, 10, MediaQuery.of(context).size.width/2-20, 10),
          )
        ],
      );
    }
  }
}
