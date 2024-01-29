import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/router.dart';

void logOutDialog() {
  Get.defaultDialog(
    title: '',
    titlePadding: const EdgeInsets.all(0),
    backgroundColor: ThemeProvider.whiteColor,
    barrierDismissible: false,
    radius: 10.r,
    content: SizedBox(
      width: 300.0, // Adjust the width as needed
      height: 200.0, // Adjust the height as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Log Out !",
            style: TextStyle(
              fontSize: 24.0, // Adjust the font size as needed
              color: ThemeProvider.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          const Text(
            "Are you sure want to log out ?",
            style: TextStyle(
              fontSize: 18.0, // Adjust the font size as needed
              color: ThemeProvider.blackColor,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeProvider.whiteColor,
                    foregroundColor: ThemeProvider.blackColor,
                    side: const BorderSide(
                      width: 2.0,
                      color: Colors.black,
                    )),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 18.0, // Adjust the font size as needed
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  logOut();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeProvider.blackColor,
                    foregroundColor: ThemeProvider.whiteColor),
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 18.0, // Adjust the font size as needed
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

logOut() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('profile_data');
  prefs.remove('access_token');
  prefs.remove('fcm_token');
  prefs.clear();
  Get.offAllNamed(AppRouter.splash);
}
