import 'package:get/get.dart';
import 'package:rtd_project/controller/profile/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(parser: Get.find()));
  }
}
