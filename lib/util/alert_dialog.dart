import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/router.dart';

void logOutDialog() {
  Get.defaultDialog(
    title: "Log Out !",
    middleText: "Are you sure want to log out ?",
    backgroundColor: ThemeProvider.whiteColor,
    titleStyle: const TextStyle(color: ThemeProvider.blackColor),
    middleTextStyle: const TextStyle(color: ThemeProvider.blackColor),
    textConfirm: "Confirm",
    textCancel: "Cancel",
    onConfirm: () {
      logOut();
      Get.offAllNamed(AppRouter.getInitialRoute());
    },
    cancelTextColor: ThemeProvider.blackColor,
    confirmTextColor: ThemeProvider.whiteColor,
    buttonColor: Colors.red,
    barrierDismissible: false,
    radius: 10.r,
  );
}

logOut() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
