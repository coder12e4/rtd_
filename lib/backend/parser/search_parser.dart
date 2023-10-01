import 'package:get/get.dart';

import '../../core/constraints/api_urls.dart';
import '../../helper/shared_pref.dart';
import '../api/api.dart';

class SearchScreenParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  SearchScreenParser({
    required this.sharedPreferencesManager,
    required this.apiService,
  });
  Future<Response> getSurties() async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    var response = await apiService.getPrivate(
        Constants.baseUrl + Constants.loanSurties, accessToken!);
    return response;
  }
}
