import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../backend/parser/profile_parser.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileParser parser;
  ProfileController({required this.parser});
  String? name;
  void getUserDatas() async {
    final responce = await parser.getUserData();
    name = 'siraj';
    update();
    log(responce.toString());
  }

  logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
