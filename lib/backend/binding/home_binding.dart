import 'package:get/get.dart';
import 'package:rtd_project/controller/home_screen_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(parser: Get.find()));
  }
}
