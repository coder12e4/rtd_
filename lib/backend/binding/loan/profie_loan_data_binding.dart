import 'package:get/get.dart';
import 'package:rtd_project/controller/loan/profile_loan_data_controller.dart';

class ProfileLoanDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileLoanDataController(parser: Get.find()));
  }
}
