import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:rtd_project/backend/model/home_data_model.dart';

import '../backend/parser/home_parser.dart';

class HomeController extends GetxController implements GetxService {
  final HomeParser parser;
  HomeController({required this.parser});
  @override
  void onInit() {
    getHomeDatas();

    super.onInit();
  }

  bool? loading = true;

  HomeData? homeData;

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
}
