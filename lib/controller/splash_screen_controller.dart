import 'package:get/get.dart';
import 'package:rtd_project/controller/authentication/login_contoller.dart';
import 'package:rtd_project/helper/router.dart';
import 'package:rtd_project/view/login_screen/login_page.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // splashDelay();
    onLogin();
  }

  Future splashDelay() async {
    Future.delayed(const Duration(seconds: 3)).then((value) => onLogin());
  }

  void onLogin() {
    Get.delete<LoginController>(force: true);
    Get.toNamed(AppRouter.getInitialRoute());
  }
}
