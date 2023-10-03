import 'package:get/get.dart';

import '../../core/constraints/api_urls.dart';
import '../../helper/shared_pref.dart';
import '../api/api.dart';

class BookScreenParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  BookScreenParser(
      {required this.sharedPreferencesManager, required this.apiService});
  Future<Response> getStates(states) async {
    return await apiService.getPublic(Constants.baseUrl + states);
  }

  Future<Response> searchBookMember(body) async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    return await apiService.postPrivate(
        Constants.baseUrl + Constants.searchBookMember, body, accessToken!);
  }
}
