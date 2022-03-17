import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:left_over/models/Product.dart';
import 'package:left_over/models/ServerNotificationModel.dart';
import 'package:left_over/models/User.dart';
import 'package:left_over/notification_service.dart';
import "package:socket_io_client/socket_io_client.dart" as IO;

class SocketService {
  IO.Socket socket;
  NotificationService notificationService = NotificationService();

  SocketService._internal();

  factory SocketService() {
    return _socketService;
  }

  static final SocketService _socketService = SocketService._internal();

  initialize() {
    socket = IO.io(
        dotenv.env['SOCKET_URI'] + "/socket",
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            .build());

    socket.on("notification", (data) {
      handleNotification(data);
    });

    socket.onConnect((_) {
      print("Connected to the Web Socket Server");
    });
  }

  connectToRoom(String roomId) {
    socket.emit("join", roomId);
  }

  handleNotification(dynamic data) {
    ServerNotificationModel serverNotificationModel =
        ServerNotificationModel.fromJson(data);
    notificationService.showNotifications(serverNotificationModel);
  }

  requestItem(Product product, User requestedBy) {
    socket.connect();
    ServerNotificationModel serverNotificationModel = ServerNotificationModel(
        from: requestedBy, to: product.user, requestedItem: product);

    socket.emit("notification", serverNotificationModel.toJson());
  }
}
