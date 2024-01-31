import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../backend/model/notification_model/notification_model.dart';
import '../backend/parser/splash_screen_parser.dart';
import '../helper/router.dart';
import '../view/notification/notification_details_screen/notification_details.dart';
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

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // App is opened by clicking on a notification
        handleBackgroundMessage(message);
      } else {
        // App is opened normally
        splashDelay();
      }
    });
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    debugPrint("Title: ${message.notification?.title}");
    dynamic k = json.decode(message.notification!.body!);
    debugPrint("Body: ${message.notification?.body}");
    debugPrint("Payload: ${message.data}");

    notificationDetails data = notificationDetails.fromJson(k);

    // Check if the app is in the foreground
    if (Get.isOverlaysOpen) {
      // If the app is in the foreground, navigate to the notification details screen
      handleRoute(data);
    } else if (Get.isOverlaysClosed) {
      handleRoute(data);
    } else {
      // If the app is in the background or terminated, open the app and then navigate
      handleRoute(data);
    }
  }

  NotificationController? notificationController;
  Future splashDelay() async {
    Future.delayed(const Duration(seconds: 3)).then((value) => onLogin());
  }

  void onLogin() {
    Get.offNamed(AppRouter.getElectedMemberRoute(), arguments: [true]);
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
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> handleBackgroudMessage(RemoteMessage message) async {
    debugPrint("Title:${message.notification?.title}");
    dynamic k = json.decode(message.notification!.body!);
    debugPrint("body:${message.notification?.body}");
    debugPrint("Payload:${message.data}");
    notificationDetails data = notificationDetails.fromJson(k);
    Get.off(const NotificationDetailsScreen(), arguments: data);
    /*  Get.toNamed(
      AppRouter.getNotificationPollRoute(),
    );*/
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      return handleBackgroudMessage(value!);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleBackgroundMessage(event);
    });

    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      if (notification == null) {
        return;
      } else {
        notificationDetails data =
            notificationDetails.fromJson(json.decode(notification.body!));

        _localNotifications.show(
            notification.hashCode,
            notification.title,
            data.message,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  _androidChannel.id, _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: '@drawable/notification_icon',
                  playSound: true),
            ),
            payload: data.message);
      }
    });

    notificationController!.getNotification();
  }

  Future initLocalNotifications() async {
    const android =
        AndroidInitializationSettings("@drawable/notification_icon");
    const settings = InitializationSettings(
      android: android,
    );
    await _localNotifications.initialize(settings);
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initNotifications() async {
    await _firebasemessageing.requestPermission();
    initPushNotifications();
    initLocalNotifications();
  }

  void handleRoute(notificationDetails data) {
    if (data.type == 1) {
      Get.toNamed(AppRouter.getLoanRequestDetailsRoutes(),
          arguments: [data.details!.id, true, 2]);
    } else if (data.type == 2) {
      Get.toNamed(AppRouter.getProfileLoanDetailsRoute(),
          arguments: [data.details!.id!]);
    } else if (data.type == 3) {
      Get.toNamed(AppRouter.getNotificationPollRoute(),
          arguments: [data.details!.id, null, true]);
    } else if (data.type == 4) {
      Get.offAndToNamed(AppRouter.loanRequestDetailsRoutes,
          arguments: [data.details!.id, false, 1]);
    } else if (data.type == 5) {
      Get.to(const NotificationDetailsScreen(), arguments: [data]);
    } else {
      Get.toNamed(AppRouter.getProfileLoanDetailsRoute(),
          arguments: [data.details!.id!]);
    }
  }
}
