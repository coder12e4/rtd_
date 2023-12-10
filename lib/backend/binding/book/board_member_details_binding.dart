import 'package:get/get.dart';
import 'package:rtd_project/controller/book/board_member_details_controller.dart';

class BoardMemberDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BoardMemberDetailsController(parser: Get.find()));
  }
}
