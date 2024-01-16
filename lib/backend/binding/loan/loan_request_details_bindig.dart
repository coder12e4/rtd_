import 'package:get/get.dart';

import '../../../controller/loan/loan_request_detail_controller.dart';

class LoanRequestDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoanRequestDetailsController(parser: Get.find()));
  }
}
