import 'package:get/get.dart';
import 'package:rtd_project/core/constraints/api_urls.dart';

import '../../helper/shared_pref.dart';
import '../api/api.dart';

class HomeParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  HomeParser(
      {required this.sharedPreferencesManager, required this.apiService});
  Future<Response> getHomeData() async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    return await apiService.getPrivate(
        Constants.baseUrl + Constants.getHomeData, accessToken!);
  }
}
