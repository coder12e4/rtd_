import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../backend/api/api.dart';
import '../../core/constraints/api_urls.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    Timer.periodic(const Duration(seconds: 3), (timer) {
      getNotification();
    });
  }

  int? notificationCount;
  Notification? notification;
  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText: const Text('PLEASE CONNECT TO THE INTERNET',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400]!,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
        Get.rawSnackbar(
            messageText: const Text('CONNECTED',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            isDismissible: false,
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.green[400]!,
            icon: const Icon(
              Icons.wifi,
              color: Colors.white,
              size: 35,
            ),
            margin: EdgeInsets.zero,
            snackStyle: SnackStyle.GROUNDED);
      }
    }
  }

  Future<void> getNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? 'NA';
    ApiService apiService = ApiService(appBaseUrl: "https://rtdkerala.com/");

    try {
      Response response = await apiService.getPrivate(
          Constants.baseUrl + Constants.getNotification, accessToken);
      // log('notification responce ${response.body}');
      if (response.statusCode == 200) {
        if (response.body != null) {
          notificationCount = response.body['data']
              .where((element) => element["seen"] == 0)
              .length;
        }

        log('Notification count $notificationCount');
        // log('Notification data ${response.body}');
      }
    } catch (e, stackTrace) {
      log('Notification Catch $e', error: e, stackTrace: stackTrace);
    }

    update();
  }
}
