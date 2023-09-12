import 'package:get/get.dart';

import '../../helper/router.dart';
import '../../helper/shared_pref.dart';

class SplashScreenParser {
  final SharedPreferencesManager sharedPreferencesManager;

  SplashScreenParser({required this.sharedPreferencesManager});
  getPage() {
    final String? token =
        sharedPreferencesManager.getString('access_token') ?? null;
    if (token != null) {
      Get.offNamed(AppRouter.getBottomNavRoute());
    } else {
      Get.offNamed(AppRouter.getInitialRoute());
    }
  }
}
