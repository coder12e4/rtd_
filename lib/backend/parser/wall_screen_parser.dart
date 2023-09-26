import 'package:get/get.dart';

import '../../core/constraints/api_urls.dart';
import '../../helper/shared_pref.dart';
import '../api/api.dart';

class WallScreenParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  WallScreenParser(
      {required this.sharedPreferencesManager, required this.apiService});
  Future<Response> getFeedData() async {
    final accessToken = sharedPreferencesManager.getString('access_token');

    return await apiService.getPrivate(
        Constants.baseUrl + Constants.getWallFeedData, accessToken!);
  }
}
