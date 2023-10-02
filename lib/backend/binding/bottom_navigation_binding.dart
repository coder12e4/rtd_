import 'package:get/get.dart';
import 'package:rtd_project/controller/home_screen_controller.dart';
import 'package:rtd_project/controller/profile/profile_controller.dart';

import '../../controller/book_screen_controller.dart';
import '../../controller/bottom_navigation_controller.dart';
import '../../controller/loan/loan_screen_controller.dart';
import '../../controller/wall_screen_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavController(parser: Get.find()));
    Get.lazyPut(() => HomeController(parser: Get.find()));
    Get.lazyPut(() => ProfileController(parser: Get.find()));
    Get.lazyPut(() => LoanScreenController(parser: Get.find()));
    Get.lazyPut(() => WallScreenController(parser: Get.find()));
    Get.lazyPut(() => BookScreenController(parser: Get.find()));
  }
}
