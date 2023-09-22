import 'package:get/get.dart';

import '../backend/parser/splash_screen_parser.dart';

class SplashScreenController extends GetxController {
  final SplashScreenParser parser;
  SplashScreenController({required this.parser});
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
    parser.getPage();
    // final token = Get.offNamed(AppRouter.getInitialRoute());
  }
}
