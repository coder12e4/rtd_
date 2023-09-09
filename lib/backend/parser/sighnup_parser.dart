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

  Future<Response> uploadImage(
    XFile data1,
    XFile data2,
    // XFile data2,
    name,
    email,
    password,
    conPassword,
    inum,
    ksanum,
    bloodgroup,
    iaddress1,
    iaddress2,
    iState,
    iPin,
    kAddress1,
    kAddress2,
    kState,
    kPin,
  ) async {
    return await apiService.uploadFiles(

      "http://rtd.canisostudio.com/api/register",

      [
        MultipartBody('document_proof_india', data1),
        MultipartBody('document_proof_ksa', data2)
      ],
      name,
      email,
      password,
      conPassword,
      inum,
      ksanum,
      bloodgroup,
      iaddress1,
      iaddress2,
      iState,
      iPin,
      kAddress1,
      kAddress2,
      kState,
      kPin,
    );
  }

  Future<Response> getStates() async {
    return await apiService
        .getPublic(Constants.baseUrl + Constants.getAllStates);
  }

  Future<Response> getBloodGroup() async {
    return await apiService

        .getPublic(Constants.baseUrl + Constants.getAllBloodGroup);

  }

  Future<void> saveToken(key, token) async {
    sharedPreferencesManager.putString(key, token);
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
