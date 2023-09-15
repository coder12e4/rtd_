import 'package:get/get.dart';

import '../../core/constraints/api_urls.dart';
import '../../helper/shared_pref.dart';
import '../api/api.dart';

class EditProfileParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  EditProfileParser(
      {required this.sharedPreferencesManager, required this.apiService});
  Future<Response> getUserData() async {
    final accessToken = sharedPreferencesManager.getString('access_token');

    return await apiService.getPrivate(
        Constants.baseUrl + Constants.getUserDetails, accessToken!);
  }

  Future<Response> getStates() async {
    return await apiService
        .getPublic(Constants.baseUrl + Constants.getAllStates);
  }

  Future<Response> getBloodGroup() async {
    return await apiService
        .getPublic(Constants.baseUrl + Constants.getAllBloodGroup);
  }
}
