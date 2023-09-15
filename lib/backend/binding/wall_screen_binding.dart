import 'package:get/get.dart';

import '../../controller/wall_screen_controller.dart';

class WallScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WallScreenController(parser: Get.find()));
  }
}
