import 'package:get/get.dart';
import 'package:rtd_project/controller/profile_edit_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController(parser: Get.find()));
  }
}
