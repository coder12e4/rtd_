import 'dart:developer';

import 'package:get/get.dart';

import '../backend/model/wall/feed_data_model.dart';
import '../backend/parser/wall_screen_parser.dart';

class WallScreenController extends GetxController {
  final WallScreenParser parser;
  WallScreenController({required this.parser});
  @override
  void onInit() {
    getFeedData();
    super.onInit();
  }

  FeedData? data;
  bool loading = true;
  Future<void> getFeedData() async {
    Response response = await parser.getFeedData();
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonData =
            Map<String, dynamic>.from(response.body);
        data = FeedData.fromJson(jsonData['data']);
        loading = false;
        log('data$data');
      } catch (e) {
        log('wall catch $e');
      }
      log('responce${response.body}');
      update();
    }
  }
}
