import 'dart:developer';

import 'package:get/get.dart';

import '../../core/constraints/api_urls.dart';
import '../../helper/shared_pref.dart';
import '../api/api.dart';

class ProfileParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  ProfileParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getUserData() async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    log('access token****************$accessToken');
    return await apiService.getPrivate(
        Constants.baseUrl + Constants.getUserDetails, accessToken!);
  }
}
