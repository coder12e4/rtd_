import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rtd_project/backend/model/home_data_model.dart';
import 'package:rtd_project/controller/notification/notification_controller.dart';

import '../backend/parser/home_parser.dart';

class HomeController extends GetxController implements GetxService {
  final HomeParser parser;
  HomeController({required this.parser});
  @override
  void onInit() {
    InternetConnectionChecker();
    controllerN = Get.put(NotificationController(parser: Get.find()));

    getHomeDatas();
    getNotificaion();
    super.onInit();
  }

  bool? loading = true;
  NotificationController? controllerN;
  HomeData? homeData;

  Future<void> getHomeDatas() async {
    Response response = await parser.getHomeData();
    try {
      if (response.statusCode == 200) {
        homeData = HomeData.fromJson(response.body);

        log(homeData!.activeLoan.toString());
      }
    } catch (e, stackTrace) {
      log("home data catch error :$e,", error: e, stackTrace: stackTrace);
    }
    loading = false;
    update();
  }

  Future<void> getNotificaion() async {
    await controllerN!.getNotification();
    update();
  }
}
