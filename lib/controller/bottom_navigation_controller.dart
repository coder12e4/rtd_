import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/parser/bottom_navigation_parser.dart';

class BottomNavController extends GetxController
    with GetTickerProviderStateMixin {
  final BottomNavParser parser;
  late TabController tabController;
  BottomNavController({required this.parser});
  int? pageIndex;
  int tabId = 0;

  @override
  void onInit() {
    try {
      tabId = int.parse(Get.arguments[0].toString());
    } catch (e, stacktrace) {
      log("Exception from tabs $e", error: e, stackTrace: stacktrace);
    }
    tabController = TabController(length: 5, vsync: this, initialIndex: tabId);
    super.onInit();

    log("tab id $tabId ");
  }

  // @override
  // void onInit() {
  //   pageIndex = 0;
  //   tabController =
  //       TabController(length: 5, vsync: this, initialIndex: pageIndex!);
  //   super.onInit();
  // }

  // void updateTabId(int index) {
  //   pageIndex = index;
  //   tabController.animateTo(pageIndex!);
  //   update();
  // }
}
