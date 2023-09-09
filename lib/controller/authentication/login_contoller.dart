import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtd_project/backend/parser/login_parser.dart';
import 'package:rtd_project/controller/authentication/regitration.dart';
import 'package:rtd_project/helper/router.dart';

import '../../backend/api/handler.dart';
import '../../backend/model/user_data_model.dart';
import '../../util/theme.dart';
import '../../util/toast.dart';

class LoginController extends GetxController implements GetxService {
  final LoginParser parser;
  LoginController({required this.parser});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RegisterController? registerController;

  bool passwordVisible = false;
  UserData? userData;
  void visibiltyValueChange() {
    passwordVisible = !passwordVisible;
    update();
  }

  Future<void> onLogin() async {
    if (emailController.text == '' ||
        emailController.text.isEmpty ||
        passwordController.text == '' ||
        passwordController.text.isEmpty) {
      showToast('All fields are required'.tr);
      return;
    }
    /*if (!GetUtils.isEmail(passwordController.text)) {
       showToast('Email is not valid'.tr);
       return;
     }*/
    var body = {
      "ksa_mobile_number": emailController.text,
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

      debugPrint(myMap['data']['id'].toString());

      /*    if (myMap['user'] != '' &&
          myMap['token'] != '' &&
          myMap['user']['type'] == 'user') {
        debugPrint(myMap['user']['id'].toString());
       // parser.saveToken(myMap['token']);
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
  */
      if (myMap['message'] != 'success') {
        showToast(myMap['message']);
        return;
      }
      if (myMap['data']['name'] != '' && myMap['access_token'] != '') {
        debugPrint(myMap['data']['id'].toString());
        parser.saveToken('access_token', myMap['access_token']);
        parser.saveInfo(UserData(
          id: myMap['data']['id'],
          name: myMap['data']['name'],
          email: myMap['data']['email'],
          emailVerifiedAt: myMap['data']['email_verified_at'],
          verificationStatus: myMap['data']['verification_status'],
          indiaMobileNumber: myMap['data']['india_mobile_number'],
          ksaMobileNumber: myMap['data']['ksa_mobile_number'],
          bloodGroup: myMap['data']['blood_group'],
          indianAddress1: myMap['data']['indian_address_1'],
          indianAddress2: myMap['data']['indian_address_2'],
          indiaState: myMap['data']['india_state'],
          indiaPin: myMap['data']['india_pin'],
          documentProofIndia: myMap['data']['document_proof_india'],
          ksaAddress1: myMap['data']['ksa_address_1'],
          ksaAddress2: myMap['data']['ksa_address_2'],
          ksaState: myMap['data']['ksa_state'],
          ksaPin: myMap['data']['ksa_pin'],
          documentProofKsa: myMap['data']['document_proof_ksa'],
          createdAt: myMap['data']['created_at'],
          updatedAt: myMap['data']['updated_at'],
          deletedAt: myMap['data']['deleted_at'],
        ));
        String? data = await parser.getString('user_data');
        Map<String, dynamic> map = jsonDecode(data!);
        userData = UserData.fromJson(map);

        log('userData***********${userData!.name}');
        successToast('Login Successful');
        Future.delayed(const Duration(seconds: 3))
            .then((value) => onLoginSuccess());
      } else {
        showToast('Access denied'.tr);
      }
    } else {
      if (response.statusCode == 401) {
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

  void onSignUp() {
    // Get.delete<RegisterController>(force: true);
    Get.toNamed(AppRouter.getSignUpRoute());
  }

  void onLoginSuccess() {
    Get.offAllNamed(AppRouter.getBottomNavRoute());
  }
}
