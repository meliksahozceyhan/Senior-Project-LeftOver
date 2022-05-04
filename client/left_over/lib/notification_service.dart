// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:left_over/Screens/Message/components/message_detail.dart';
import 'package:left_over/helpers/NavigationService.dart';
import 'package:left_over/models/ServerNotificationModel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:left_over/models/User.dart';
import 'package:left_over/models/message/RoomModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  //NotificationService a singleton object
  static final NotificationService _notificationService =
      NotificationService._internal();

  int notificationCounter = 0;

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';
  static const channelName = "left_over_item_notification";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> requestIOSPermissions() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  // ignore: prefer_final_fields
  AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(channelId, channelName, 'channel description',
          playSound: true,
          priority: Priority.high,
          importance: Importance.high,
          icon: '@mipmap/ic_launcher');

  // ignore: prefer_final_fields
  IOSNotificationDetails _iosNotificationDetails = const IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: null);

  Future<void> init() async {
    print("Initializing Notification Manager");
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future<void> showNotifications(
      ServerNotificationModel serverNotificationModel) async {
    await flutterLocalNotificationsPlugin.show(
        notificationCounter,
        "One of your listings have been requested",
        "${serverNotificationModel.requestedItem.itemName} has been requested by ${serverNotificationModel.from.fullName}",
        NotificationDetails(
          android: _androidNotificationDetails,
          iOS: _iosNotificationDetails,
        ),
        payload: serverNotificationModel.from.id);
    notificationCounter++;
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future selectNotification(String fromUserId) async {
  final prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  Map<String, dynamic> payload = Jwt.parseJwt(token);
  User currentUser = User.fromJson(payload);

  var url =
      Uri.parse(dotenv.env['API_URL'] + "/room/createRoomViaNotification");

  var postBody = {
    "participant1": currentUser.toJson(),
    "participant2": {"id": fromUserId}
  };

  Map<String, String> headers = new Map<String, String>();
  headers["Authorization"] = "Bearer " + token;
  headers["Content-Type"] = "application/json";

  var body = json.encode(postBody);

  var response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 201) {
    var roomModel = RoomModel.fromJson(jsonDecode(response.body));
    Navigator.push(
        NavigationService.navigatorKey.currentContext,
        MaterialPageRoute(
            builder: (context) => MessageDetail(
                  roomModel: roomModel,
                )));
  }
}
