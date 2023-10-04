import 'package:get/get.dart';
import 'package:rtd_project/controller/book/service_member_details_controller.dart';

class ServiceMemberDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceMemberDetailsController(parser: Get.find()));
  }
}
