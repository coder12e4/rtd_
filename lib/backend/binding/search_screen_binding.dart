import 'package:get/get.dart';

import '../../controller/searh_screen_controller.dart';

class SearchScreenBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => SearchScreenController(parser: Get.find()));
  }
}
