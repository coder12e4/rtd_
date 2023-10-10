import 'package:get/get.dart';
import 'package:rtd_project/controller/loan/loan_details_controller.dart';

class LoanDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoanDetailsController(parser: Get.find()));
  }
}
