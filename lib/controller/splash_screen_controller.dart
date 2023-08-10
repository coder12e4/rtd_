import 'package:get/get.dart';
import 'package:rtd_project/view/register_screen/register_screen.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    splashDelay();
  }

  Future splashDelay() async {
    Future.delayed(const Duration(seconds: 3))
        .then((value) => Get.to(const RegisterScreen()));
  }
}
