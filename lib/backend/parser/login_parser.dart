import 'package:get/get.dart';

import 'package:rtd_project/backend/api/api.dart';
import 'package:rtd_project/core/constraints/api_urls.dart';
import 'package:rtd_project/helper/shared_pref.dart';

class LoginParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  LoginParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> login(dynamic body) async {
    var response = await apiService.postPublic(
        Constants().baseUrl + Constants().login, body);
    return response;
  }

  Future<void> saveToken(key, token) async {
    sharedPreferencesManager.putString(key, token);
  }
}
