import 'package:get/get.dart';

import '../../../core/constraints/api_urls.dart';
import '../../../helper/shared_pref.dart';
import '../../api/api.dart';

class ServiceMemberDetailsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  ServiceMemberDetailsParser(
      {required this.sharedPreferencesManager, required this.apiService});
  Future<Response> getServiceMemberDetails({serviceMemberId}) async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    return await apiService.getPrivate(
        '${Constants.baseUrl + Constants.getServiceMemberDetails}$serviceMemberId',
        accessToken!);
  }
}
