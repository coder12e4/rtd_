import 'package:get/get.dart';
import 'package:rtd_project/controller/splash_screen_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      ()=> SplashScreenController()
    );
  }
}
