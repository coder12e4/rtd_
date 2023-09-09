import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:rtd_project/backend/api/api.dart';
import 'package:rtd_project/helper/shared_pref.dart';

import '../model/user_data_model.dart';

class LoginParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  LoginParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> login(dynamic body) async {
    var response = await apiService.postPublic(
        "http://rtd.canisostudio.com/api/user/login", body);
    return response;
  }

  Future<void> saveInfo(UserData userData) async {
    log(userData.name.toString());
    final jsondata = userData.toJson();
    final data = jsonEncode(jsondata);
    await sharedPreferencesManager.putString('user_data', data);

    log('saved data .......$data');
  }
}
