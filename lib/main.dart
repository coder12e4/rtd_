import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/core/constraints/http_certificate/http_certificate.dart';
import 'package:rtd_project/helper/init.dart';
import 'package:rtd_project/helper/router.dart';
import 'package:rtd_project/util/theme.dart';

import 'backend/notification/push_notification.dart';

Future<void> main() async {
  // Get.put(Athentication())
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ThemeProvider.appColor, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  await MainBinding().dependencies();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
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
      builder: (context, child) {
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
// //
// //start
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyController extends GetxController {
//   var progress = 0.0;
//
//   // Simulate some task that updates the progress.
//   Future<void> simulateTask() async {
//     for (var i = 0; i < 100; i++) {
//       await Future.delayed(Duration(milliseconds: 100));
//       progress = (i + 1) / 100;
//       update();
//     }
//   }
// }
//
// class MyApp extends StatelessWidget {
//   final MyController myController = MyController();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('GetBuilder Linear Progress Indicator'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               GetBuilder<MyController>(
//                 init: myController,
//                 builder: (controller) {
//                   return LinearProgressIndicator(
//                     value: controller.progress,
//                     backgroundColor: Colors.grey[300],
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//                   );
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   await myController.simulateTask();
//                 },
//                 child: Text('Start Task'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
