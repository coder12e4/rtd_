import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; 
import 'package:rtd_project/core/constraints/http_certificate/http_certificate.dart';
import 'package:rtd_project/helper/init.dart';
import 'package:rtd_project/helper/router.dart';
import 'package:rtd_project/util/theme.dart';

Future<void> main() async {
  // Get.put(Athentication());
  WidgetsFlutterBinding.ensureInitialized();
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
//  
//start
