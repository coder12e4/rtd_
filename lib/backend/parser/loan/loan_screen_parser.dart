import 'package:get/get.dart';

import '../../../core/constraints/api_urls.dart';
import '../../../helper/shared_pref.dart';
import '../../api/api.dart';

class LoanScreenParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  LoanScreenParser(
      {required this.sharedPreferencesManager, required this.apiService});
  Future<Response> getLoanTypes() async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    var response = await apiService.getPrivate(
        Constants.baseUrl + Constants.loanType, accessToken!);
    return response;
  }

  // Future<Response> getLoanPurpose(body) async {
  //   final accessToken = sharedPreferencesManager.getString('access_token');
  //   var response = await apiService.postPrivate(
  //       Constants.baseUrl + Constants.getLonPurpose, body, accessToken!);
  //   return response;
  // }

  Future<Response> getSurties() async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    var response = await apiService.getPrivate(
        Constants.baseUrl + Constants.loanSurties, accessToken!);
    return response;
  }

  Future<Response> cancelLoanRequest(body) async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    var response = await apiService.postPrivate(
        Constants.baseUrl + Constants.cancelLoanRequest, body, accessToken!);
    return response;
  }

  Future<Response> uploadLoneDocument(body) async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    var response = await apiService.postPrivate(
        Constants.baseUrl + Constants.uploadLoanDocument, body, accessToken!);
    return response;
  }

  Future<Response> getLoanRequestData() async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    var response = await apiService.getPrivate(
        Constants.baseUrl + Constants.getLoanRequest, accessToken!);
    return response;
  }

  Future<Response> getLoanPurpose(body) async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    var response = await apiService.postPrivate(
        Constants.baseUrl + Constants.getLonPurpose, body, accessToken!);
    return response;
  }
}
