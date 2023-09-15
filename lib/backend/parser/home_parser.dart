import 'package:get/get.dart';

import '../../helper/shared_pref.dart';
import '../api/api.dart';

class HomeParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  HomeParser(
      {required this.sharedPreferencesManager, required this.apiService});
  Future<Response> getHomeData() async {
    return await apiService.getPublic(
        'https://run.mocky.io/v3/e5f91d38-5ce2-4df8-9c81-4c22d21e08e1');
  }
}
