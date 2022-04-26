import 'dart:ffi';

import 'package:left_over/models/User.dart';
import 'package:left_over/models/message/RoomModel.dart';

class MessageModel {
  String id, createdAt, updatedAt, content;
  bool isRead;
  User from;
  RoomModel to;

  MessageModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.content,
      this.isRead,
      this.from,
      this.to});

  MessageModel.localMessage({
    this.content,
    this.from,
    this.isRead,
    this.to,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        id: json['id'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        content: json['content'],
        isRead: json['isRead'],
        from: User.fromJson(json['from']),
        to: RoomModel.fromJson(json['to']));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "content": content,
      "isRead": isRead,
      "from": from.toJson(),
      "to": to.toJson()
    };
  }
}
