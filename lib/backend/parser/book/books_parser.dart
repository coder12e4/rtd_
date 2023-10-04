import 'package:get/get.dart';

import '../../../core/constraints/api_urls.dart';
import '../../../helper/shared_pref.dart';
import '../../api/api.dart';

class BookScreenParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  BookScreenParser(
      {required this.sharedPreferencesManager, required this.apiService});
  Future<Response> getStates(states) async {
    return await apiService.getPublic(Constants.baseUrl + states);
  }

  Future<Response> getServices() async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    return await apiService.getPrivate(
        Constants.baseUrl + Constants.getServices, accessToken!);
  }

  Future<Response> getServiceMemberList({stateId, serviceId, query}) async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    return await apiService.getPrivate(
        "${Constants.baseUrl}api/user/service/members/list?state_id=$stateId&service_id=$serviceId&search=$query",
        accessToken!);
  }

  Future<Response> searchBookMember(body) async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    return await apiService.postPrivate(
        Constants.baseUrl + Constants.searchBookMember, body, accessToken!);
  }
}
