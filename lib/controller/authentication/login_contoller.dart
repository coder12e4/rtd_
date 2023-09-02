import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtd_project/backend/api/handler.dart';
import 'package:rtd_project/backend/parser/login_parser.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:rtd_project/util/toast.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController implements GetxService {
  LoginController({required this.parser});
  final LoginParser parser;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  Future<void> onLogin() async {
    if (emailController.text == '' ||
        emailController.text.isEmpty ||
        passwordController.text == '' ||
        passwordController.text.isEmpty) {
      showToast('All fields are required'.tr);
      return;
    }
    if (!GetUtils.isEmail(passwordController.text)) {
      showToast('Email is not valid'.tr);
      return;
    }
    var body = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    Get.dialog(
      SimpleDialog(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              const CircularProgressIndicator(
                color: ThemeProvider.appColor,
              ),
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                  child: Text(
                "Please wait".tr,
                style: const TextStyle(fontFamily: 'bold'),
              )),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );

    var response = await parser.login(body);
    Get.back();

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      debugPrint(myMap['user']['id'].toString());

      if (myMap['user'] != '' &&
          myMap['token'] != '' &&
          myMap['user']['type'] == 'user') {
        debugPrint(myMap['user']['id'].toString());
        parser.saveToken(myMap['token']);
        parser.saveInfo(
          myMap['user']['id'].toString(),
          myMap['user']['first_name'].toString(),
          myMap['user']['last_name'].toString(),
          myMap['user']['cover'].toString(),
          myMap['user']['email'].toString(),
          myMap['user']['mobile'].toString(),
        );
        var updateParam = {
          "id": myMap['user']['id'].toString(),
          'fcm_token': parser.getFcmToken(),
        };
        await parser.updateProfile(updateParam, myMap['token']);
        onNavigate();
      } else {
        showToast('Access denied'.tr);
      }
    } else if (response.statusCode == 401) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }
}
