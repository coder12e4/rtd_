import 'package:get/get.dart';

import '../../../controller/loan/loan_screen_controller.dart';

class LoanScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoanScreenController(parser: Get.find()));
  }
}
