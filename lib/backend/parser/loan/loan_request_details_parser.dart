import 'package:get/get.dart';

import '../../../core/constraints/api_urls.dart';
import '../../../helper/shared_pref.dart';
import '../../api/api.dart';

class LoanRequestDetailsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  LoanRequestDetailsParser(
      {required this.sharedPreferencesManager, required this.apiService});
  Future<Response> getLoanRequestDetails(body) async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    var response = await apiService.postPrivate(
        Constants.baseUrl + Constants.loanRequestDetails, body, accessToken!);
    return response;
  }
}
