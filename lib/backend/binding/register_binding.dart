import 'package:get/get.dart';
import 'package:rtd_project/controller/authentication/regitration.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      ()=> RegisterController(parser: Get.find())
    );
  }
}
