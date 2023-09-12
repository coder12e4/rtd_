import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../backend/model/profile_model.dart';
import '../backend/parser/profile_parser.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileParser parser;
  ProfileController({required this.parser});
  Profile? userData;
  bool loading = true;
  @override
  void onInit() {
    getUserDatas();
    super.onInit();
  }

  void getUserDatas() async {
    final response = await parser.getUserData();

    if (response.statusCode == 200) {
      try {
        log(response.statusCode.toString());
        Map<String, dynamic> data = Map<String, dynamic>.from(response.body);

        userData = Profile.fromJson(data);
        log(data.toString());
        log(userData!.data.name.toString());
        loading = false;
      } catch (e) {
        log(e.toString());
      }
    } else {
      log(response.body.toString());
    }
    update();
  }

  logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
