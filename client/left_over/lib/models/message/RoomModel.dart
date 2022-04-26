import 'package:left_over/models/User.dart';

class RoomModel {
  String id, createdAt, updatedAt;
  User participant1, participant2;

  RoomModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.participant1,
      this.participant2});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
        id: json['id'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        participant1: User.fromJson(json['participant1']),
        participant2: User.fromJson(json['participant2']));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "participant1": participant1.toJson(),
      "participant2": participant2.toJson()
    };
  }
}
