import 'dart:async';
import 'dart:developer';

import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtd_project/backend/model/home_data_model.dart';
import 'package:rtd_project/controller/notification/notification_controller.dart';

import '../backend/parser/home_parser.dart';

class HomeController extends GetxController implements GetxService {
  final HomeParser parser;
  HomeController({required this.parser});
  @override
  void onInit() {
    controllerN = Get.put(NotificationController(parser: Get.find()));

    getHomeDatas();
    getNotificaion();
    super.onInit();
  }

  bool? loading = true;
  NotificationController? controllerN;
  HomeData? homeData;
  GlobalKey<AnimatedCircularChartState> chartKey =
      GlobalKey<AnimatedCircularChartState>();

  Future<void> getHomeDatas() async {
    Response response = await parser.getHomeData();
    log("home data responce ${response.body}");
    try {
      if (response.statusCode == 200) {
        homeData = HomeData.fromJson(response.body);

        loading = false;
      }
    } catch (e, stackTrace) {
      log("home data catch error :$e,", error: e, stackTrace: stackTrace);
    }

    update();
  }

  Future<void> getNotificaion() async {
    // Get.find<NotificationController>().getNotification();
    await controllerN!.getNotification();
    update();
  }
}
