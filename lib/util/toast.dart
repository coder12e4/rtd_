import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void showToast(String message, {bool isError = true}) {
  HapticFeedback.lightImpact();
  Get.showSnackbar(GetSnackBar(
    backgroundColor: isError ? Colors.red : Colors.black,
    message: message.tr,
    duration: const Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  ));
}

void successToast(String message) {
  HapticFeedback.lightImpact();
  Get.showSnackbar(GetSnackBar(
    backgroundColor: Colors.green,
    message: message.tr,
    duration: const Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  ));
}
