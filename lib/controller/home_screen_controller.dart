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
  void onInit() async {
    InternetConnectionChecker();
    controllerN = Get.put(NotificationController(parser: Get.find()));

    await getHomeDatas();
    getNotificaion();
    super.onInit();
  }

  NotificationController? controllerN;
  HomeData? homeData;
  final _homeDataController = StreamController<HomeData>();

  Stream<HomeData> get homeDataStream => _homeDataController.stream;

  Future<HomeData> getHomeDatas() async {
    Response response = await parser.getHomeData();

    if (response.statusCode == 200) {
      HomeData data = HomeData.fromJson(response.body);
      homeData = data;
      log(data.activeLoan.toString());

      _homeDataController.add(data); // Emit data to the stream
    }
    return homeData!;
  }

  Future<void> getNotificaion() async {
    await controllerN!.getNotification();
    update();
  }
}
