import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtd_project/backend/api/api.dart';
import 'package:rtd_project/backend/api/handler.dart';
import 'package:rtd_project/backend/parser/login_parser.dart';
import 'package:rtd_project/core/constraints/api_urls.dart';
import 'package:rtd_project/helper/router.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:rtd_project/util/toast.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController implements GetxService {
  final LoginParser parser;
  LoginController({required this.parser});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ksaMobNumController = TextEditingController();

  Future<void> onLogin() async {
    if (emailController.text == '' ||
        emailController.text.isEmpty ||
        passwordController.text == '' ||
        passwordController.text.isEmpty ||
        ksaMobNumController.text == '' ||
        ksaMobNumController.text.isEmpty) {
      showToast('All fields are required'.tr);
      return;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      showToast('Email is not valid'.tr);
      return;
    }
    Map<String, String> body = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "ksa_mobile_number": ksaMobNumController.text.trim()
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
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );

    try {
      var response = await parser.login(body);
      Get.back(); // Remove the dialog here
      Get.back(); // Remove the dialog here

      log('from controller ${response.statusCode}');
      log(passwordController.text);
      log(ksaMobNumController.text);
      log(body.toString());

      // Handle the response as needed
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        log(myMap['data'].toString());
        log(myMap['access_token'].toString());
        log(myMap['status'].toString());

        if (myMap['access_token'] != '' && myMap['status'] == true) {
          // debugPrint(myMap['data']['id'].toString());s
          parser.saveToken('logintoken', myMap['access_token']);
          // parser.saveInfo(
          //   myMap['user']['id'].toString(),
          //   myMap['user']['first_name'].toString(),
          //   myMap['user']['last_name'].toString(), 
          //   myMap['user']['cover'].toString(),
          //   myMap['user']['email'].toString(),
          //   myMap['user']['mobile'].toString(),
          // );
          // var updateParam = {
          //   "id": myMap['user']['id'].toString(),
          //   'fcm_token': parser.getFcmToken(),
          // };
          // await parser.updateProfile(updateParam, myMap['token']);
          // onNavigate();
          successToast('Login Successfull');
        } else {
          showToast('Access denied'.tr);
        }
      } else {
        if (response.statusCode == 401) {
          Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
          if (myMap['message'] != '') {
            showToast(myMap['message'.tr]);
          } else {
            showToast('Something went wrong'.tr);
          }
          update();
        } else if (response.statusCode == 500) {
          Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
          if (myMap['message'] != '') {
            showToast(myMap['message'.tr]);
          } else {
            showToast('Something went wrong'.tr);
          }
          update();
        } else {
          ApiChecker.checkApi(response);
          update();
        }
      }
    } catch (error) {
      Get.back(); // Remove the dialog in case of an error
      // Handle any other errors that occur during the request
      print("Error: $error");
    }
  }

  void onSignUp() {
    // Get.delete<RegisterController>(force: true);
    Get.toNamed(AppRouter.getSignUpRoute());
  }
}
