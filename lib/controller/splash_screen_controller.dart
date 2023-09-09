import 'package:get/get.dart';
import 'package:rtd_project/helper/router.dart';


class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    splashDelay();
    // onLogin();
  }

  Future splashDelay() async {
    Future.delayed(const Duration(seconds: 3)).then((value) => onLogin());
  }

  void onLogin() {
   // Get.delete<LoginController>(force: true);
    Get.toNamed(AppRouter.getInitialRoute());
  }
}
