import 'package:get/get.dart';
import 'package:rtd_project/controller/notification/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController(parser: Get.find()));
  }
}
