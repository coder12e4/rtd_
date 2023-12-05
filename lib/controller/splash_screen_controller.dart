import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../backend/parser/splash_screen_parser.dart';
import '../helper/router.dart';
import 'notification/notification_controller.dart';

class SplashScreenController extends GetxController {
  final SplashScreenParser parser;
  SplashScreenController({required this.parser});
  @override
  void onInit() {
    super.onInit();
    notificationController =
        Get.put(NotificationController(parser: Get.find()));
    initNotifications();
    FirebaseMessaging.instance.getToken().then((value) {
      log('fcm token from splash $value');
      parser.saveDeviceToken(value.toString());
    });

    splashDelay();
  }

  NotificationController? notificationController;
  Future splashDelay() async {
    Future.delayed(const Duration(seconds: 3)).then((value) => onLogin());
  }

  void onLogin() {
    Get.offNamed(AppRouter.getElectedMemberRoute());
    Future.delayed(const Duration(seconds: 3))
        .then((value) => parser.getPage());
    //
  }

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
    notificationController!.getNotification();
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
