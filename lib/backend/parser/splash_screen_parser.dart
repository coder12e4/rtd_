import 'package:get/get.dart';

import '../../helper/router.dart';
import '../../helper/shared_pref.dart';

class SplashScreenParser {
  final SharedPreferencesManager sharedPreferencesManager;

  SplashScreenParser({required this.sharedPreferencesManager});
  getPage() {
    final String? token = sharedPreferencesManager.getString('access_token');
    if (token != null) {
      Get.offNamed(AppRouter.getBottomNavRoute(), arguments: [0]);
    } else {
      Get.offNamed(AppRouter.getInitialRoute());
    }
  }

  void saveDeviceToken(String token) {
    sharedPreferencesManager.putString('fcm_token', token);
  }
}
