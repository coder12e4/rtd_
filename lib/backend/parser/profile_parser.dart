import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../core/constraints/api_urls.dart';
import '../../helper/shared_pref.dart';
import '../api/api.dart';
import '../model/profile_model.dart';

class ProfileParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  ProfileParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getUserData() async {
    final accessToken = sharedPreferencesManager.getString('access_token');

    return await apiService.getPrivate(
        Constants.baseUrl + Constants.getUserDetails, accessToken!);
  }

  Future<void> saveProfileData(Data userData) async {
    final jsonData = userData.toJson();
    final data = jsonEncode(jsonData);
    await sharedPreferencesManager.putString('profile_data', data);

    log('saved data .......$data');
  }
}
