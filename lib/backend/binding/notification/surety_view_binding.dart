import 'package:get/get.dart';
import 'package:rtd_project/controller/notification/surety_view_controller.dart';

class SuretyViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SuretyViewController(parser: Get.find()));
  }
}
