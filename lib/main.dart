import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/splash_screen_controller.dart';
import 'package:rtd_project/core/constraints/http_certificate/http_certificate.dart';
import 'package:rtd_project/helper/init.dart';
import 'package:rtd_project/helper/router.dart';
import 'package:rtd_project/util/theme.dart';
import 'dart:convert';
import '../backend/model/notification_model/notification_model.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ThemeProvider.appColor, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  //await FirebaseApi().initNotifications();
  await MainBinding().dependencies();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  final _localNotifications = FlutterLocalNotificationsPlugin();
  await Firebase.initializeApp();
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    "High importance Notifications",
    description: "Booking done",
    importance: Importance.defaultImportance,
  );
  notificationDetails data =
      notificationDetails.fromJson(json.decode(message.notification!.body!));
  _localNotifications.show(
      message.hashCode,
      message.category,
      data.message,
      NotificationDetails(
        android: AndroidNotificationDetails(
            _androidChannel.id, _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/notification_icon',
            playSound: true),
      ),
      payload: data.message);

  print("Handling a bacccccckground message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 690),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'RTD',
          color: ThemeProvider.appColor,
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          initialRoute: AppRouter.splash,
          getPages: AppRouter.routes,
          defaultTransition: Transition.fadeIn,
          // translations: LocaleString(),

          theme: ThemeData(
            fontFamily: 'JekoFont',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          locale: const Locale('en', 'US'),
        );
      },
    );
  }
}
