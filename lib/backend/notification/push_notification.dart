import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseApi {
  final _firebasemessageing = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    "High importance Notifications",
    description: "Booking done",
    importance: Importance.defaultImportance,
  );
  final _localNotications = FlutterLocalNotificationsPlugin();
  Future<void> handleBackgroudMessage(RemoteMessage message) async {
    debugPrint("Title:${message.notification?.title}");
    debugPrint("body:${message.notification?.body}");
    debugPrint("Payload:${message.data}");
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => handleBackgroudMessage);
    FirebaseMessaging.onMessageOpenedApp
        .listen((event) => handleBackgroudMessage);
    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      if (notification == null) return;
      _localNotications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                _androidChannel.id, _androidChannel.name,
                channelDescription: _androidChannel.description,
                icon: '@drawable/ic_launcher',
                playSound: true),
          ),
          payload: jsonEncode(event.toMap()));
    });
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings("@drawable/ic_launcher");
    const settings = InitializationSettings(
      android: android,
    );
    await _localNotications.initialize(settings);
    final platform = _localNotications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initNotifications() async {
    // final pref = await SharedPreferences.getInstance();
    await _firebasemessageing.requestPermission();
    // final fcmToken = await _firebasemessageing.getToken();
    // debugPrint("fcm token --  $fcmToken");
    // await pref.setString('fcm_token', fcmToken!);
    initPushNotifications();
    initLocalNotifications();
  }
}
