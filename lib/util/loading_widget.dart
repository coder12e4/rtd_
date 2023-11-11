import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtd_project/util/theme.dart';

Future<dynamic> loadingWidget() {
  return Get.dialog(
    SimpleDialog(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            const CircularProgressIndicator(
              color: ThemeProvider.appColor,
            ),
            const SizedBox(
              width: 30,
            ),
            SizedBox(
                child: Text(
              "Please wait".tr,
              style: const TextStyle(fontFamily: 'bold'),
            )),
          ],
        )
      ],
    ),
    barrierDismissible: false,
  );
}
