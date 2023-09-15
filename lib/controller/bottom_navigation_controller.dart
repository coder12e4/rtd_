import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/parser/bottom_navigation_parser.dart';

class BottomNavController extends GetxController
    with GetTickerProviderStateMixin {
  final BottomNavParser parser;
  late TabController tabController;
  BottomNavController({required this.parser});
  int? pageIndex;
  @override
  void onInit() {
    pageIndex = 0;
    tabController =
        TabController(length: 5, vsync: this, initialIndex: pageIndex!);
    super.onInit();
  }

  void updateTabId(int index) {
    pageIndex = index;
    tabController.animateTo(pageIndex!);
    update();
  }
}
