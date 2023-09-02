import 'package:get/get.dart';
import 'package:rtd_project/controller/authentication/login_contoller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      ()=> LoginController(parser: Get.find())
    );
  }
}