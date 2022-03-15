import 'package:left_over/models/Product.dart';
import 'package:left_over/models/User.dart';

class ServerNotificationModel {
  User from, to;
  Product requestedItem;

  ServerNotificationModel({this.from, this.to, this.requestedItem});

  factory ServerNotificationModel.fromJson(Map<String, dynamic> json) {
    return ServerNotificationModel(
        from: User.fromJson(json['from']),
        to: User.fromJson(json['to']),
        requestedItem: Product.fromJson(json['requestedItem']));
  }

  Map<String, dynamic> toJson() {
    return {
      "to": to.toJson(),
      "from": from.toJson(),
      "requestedItem": requestedItem.toJson()
    };
  }
}
