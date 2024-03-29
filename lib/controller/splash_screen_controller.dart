import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../backend/model/notification_model/notification_model.dart';
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
    _localNotifications.show(
        message.hashCode,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
              _androidChannel.id, _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/notification_icon',
              playSound: true),
        ),
        payload: message.notification!.body);

    if (message.notification!.body != "") {
      if (Get.isOverlaysOpen) {
        handleRoute();
      } else if (Get.isOverlaysClosed) {
        handleRoute();
      } else {
        handleRoute();
      }
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
    dynamic k = json.decode(message.notification!.body!);
    notificationDetails data = notificationDetails.fromJson(k);
    print('background notification data $data');
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
      final notification = event.notification;
      if (notification == null) {
        return;
      } else {
        //   notificationDetails data = notificationDetails.fromJson(json.decode(notification.body!));
        _localNotifications.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  _androidChannel.id, _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: '@drawable/notification_icon',
                  playSound: true),
            ),
            payload: notification.body);
      }
      handleBackgroundMessage(event);
    });

    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      AndroidNotification? android = event.notification?.android;

      //  notificationDetails data = notificationDetails.fromJson(json.decode(event.notification!.body!));
      _localNotifications.show(
          notification.hashCode,
          notification!.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                _androidChannel.id, _androidChannel.name,
                channelDescription: _androidChannel.description,
                icon: '@drawable/notification_icon',
                playSound: true),
          ),
          payload: notification.title);
    });

    FirebaseMessaging.onBackgroundMessage(
        (message) => handleBackgroundMessage(message));

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

  void handleRoute(/*notificationDetails data*/) {
    Get.delete<NotificationController>(force: true);
    Get.toNamed(AppRouter.getNotificationPageRoute());

/*
    if (data.type == 1) {
      notificationController?.markNotificationSeen(data.id!);
      Get.toNamed(AppRouter.getLoanRequestDetailsRoutes(),
          arguments: [data.details!.id, true, 2]);
    } else if (data.type == 2) {
      notificationController?.markNotificationSeen(data.id!);
      Get.toNamed(AppRouter.getProfileLoanDetailsRoute(),
          arguments: [data.details!.id!]);
    } else if (data.type == 3) {
      notificationController?.markNotificationSeen(data.id!);
      Get.toNamed(AppRouter.getNotificationPollRoute(),
          arguments: [data.details!.id, null, true, 1]);
    } else if (data.type == 4) {
      if (data.details?.loanRequestStatus == 0) {
        notificationController?.markNotificationSeen(data.id!);
        Get.toNamed(AppRouter.getSuretyRequestDetailsRoute(),
            arguments: [data.details?.id, data, false, 1]);
      } else {
        notificationController?.markNotificationSeen(data.id!);
        Get.offAndToNamed(AppRouter.loanRequestDetailsRoutes,
            arguments: [data.details!.id, false, 1]);
      }
    } else if (data.type == 5) {
      notificationController?.markNotificationSeen(data.id!);
      Get.to(const NotificationDetailsScreen(), arguments: [data]);
    } else {
      notificationController?.markNotificationSeen(data.id!);
      Get.toNamed(AppRouter.getProfileLoanDetailsRoute(),
          arguments: [data.details!.id!]);
    }
*/
  }
}
