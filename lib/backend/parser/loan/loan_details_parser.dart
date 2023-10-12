import 'package:get/get.dart';

import '../../../core/constraints/api_urls.dart';
import '../../../helper/shared_pref.dart';
import '../../api/api.dart';

class LoanDetailsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  LoanDetailsParser(
      {required this.sharedPreferencesManager, required this.apiService});
  Future<Response> getActiveLoan() async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    var response = await apiService.getPrivate(
        Constants.baseUrl + Constants.getActiveLoan, accessToken!);
    return response;
  }

  Future<Response> getClosedLoan() async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    var response = await apiService.getPrivate(
        Constants.baseUrl + Constants.getClosedLoan, accessToken!);
    return response;
  }

  Future<Response> getLoanDetails(body) async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    var response = await apiService.postPrivate(
        Constants.baseUrl + Constants.getProfileLoanData, body, accessToken!);
    return response;
  }
}
