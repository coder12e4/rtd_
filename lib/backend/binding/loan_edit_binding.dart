import 'package:get/get.dart';
import 'package:rtd_project/controller/loan/loan_edit_controller.dart';

class LoanEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoanEditController(parser: Get.find()));
  }
}
