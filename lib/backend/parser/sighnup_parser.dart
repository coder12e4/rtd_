import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/backend/api/api.dart';
import 'package:rtd_project/core/constraints/api_urls.dart';
import 'package:rtd_project/helper/shared_pref.dart';

class SignUpParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  SignUpParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> uploadImage(XFile data) async {
    return await apiService
        .uploadFiles(Constants().baseUrl+Constants().register, [MultipartBody('image', data)]);
  }

  // Future<Response> verifyEmail(dynamic body) async {
  //   var response = await apiService.postPublic(AppConstants.verifyEmail, body);
  //   return response;
  // }

  // Future<Response> verifyPhone(dynamic body) async {
  //   var response =
  //       await apiService.postPublic(AppConstants.verifyPhoneRegister, body);
  //   return response;
  // }

  // Future<Response> verifyOTP(dynamic param) async {
  //   return await apiService.postPublic(AppConstants.verifyOTPEmail, param);
  // }

  // String getSMSName() {
  //   return sharedPreferencesManager.getString('smsName') ??
  //       AppConstants.defaultSMSGateway;
  // }

  // Future<Response> getHomeCities() async {
  //   var response = await apiService.getPublic(AppConstants.getHomeCities);
  //   return response;
  // }

  // Future<Response> checkPhoneExist(dynamic body) async {
  //   var response =
  //       await apiService.postPublic(AppConstants.checkPhoneExist, body);
  //   return response;
  // }

  // Future<Response> saveMyRequest(dynamic body) async {
  //   var response =
  //       await apiService.postPublic(AppConstants.saveMyRequest, body);
  //   return response;
  // }
}