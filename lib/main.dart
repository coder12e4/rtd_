import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Import the 'get' package
import 'package:rtd_project/core/constraints/api_urls.dart';
import 'package:rtd_project/helper/init.dart';
import 'package:rtd_project/helper/router.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:rtd_project/view/splash_screen/splash_page.dart';

Future<void> main() async {
  // Get.put(Athentication());
  WidgetsFlutterBinding.ensureInitialized();
  await MainBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  }); // Fix the constructor by using 'Key?' instead of 'super.key'

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
          locale: const Locale('en', 'US'),
        );
      },
    );
  }
}
//start
