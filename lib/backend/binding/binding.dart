import 'package:get/get.dart';
import 'package:rtd_project/controller/authentication/auth.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      ()=> Athentication(parser: Get.find())
    );
  }
}
