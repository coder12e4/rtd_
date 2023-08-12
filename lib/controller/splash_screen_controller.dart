import 'package:get/get.dart';
import 'package:rtd_project/view/login_screen/login_page.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    

    super.onInit();
    splashDelay();
  }

  Future splashDelay() async {
    Future.delayed(const Duration(seconds: 3))
        .then((value) => Get.to(const LOginPage()));
  }
}
