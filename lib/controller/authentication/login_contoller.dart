import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtd_project/backend/parser/authentication/login_parser.dart';
import 'package:rtd_project/controller/authentication/regitration.dart';
import 'package:rtd_project/helper/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../backend/api/handler.dart';
import '../../backend/model/user_data_model.dart';
import '../../util/theme.dart';
import '../../util/toast.dart';
import '../../view/login_screen/widgets/document_not_attached.dart';
import '../../view/register_screen/widgets/register_success.dart';

class LoginController extends GetxController implements GetxService {
  final LoginParser parser;
  LoginController({required this.parser});
  @override
  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();
  RegisterController? registerController;
  bool? indiadoc;
  bool? ksasdoc;
  bool passwordVisible = true;
  // UserData? userData;
  void visibiltyValueChange() {
    passwordVisible = !passwordVisible;
    update();
  }

  Future<void> onLogin() async {
    if (mobileNumberController.text == '' ||
        mobileNumberController.text.isEmpty ||
        passwordController.text == '' ||
        passwordController.text.isEmpty) {
      showToast('All fields are required'.tr);
      return;
    }

    var body = {
      "ksa_mobile_number": mobileNumberController.text,
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
    Map<String, dynamic> myMap = {};
    myMap.clear();
    if (response.statusCode == 200) {
      myMap = Map<String, dynamic>.from(response.body);

      if (myMap['status'] != true) {
        showToast(myMap['message']);
        return;
      }
      if (myMap['data']['name'] != '' && myMap['access_token'] != '') {
        debugPrint(myMap['data']['id'].toString());

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
        // String? data = await parser.getString('user_data');
        // Map<String, dynamic> map = jsonDecode(data!);
        // userData = UserData.fromJson(map);
        //
        // log('userData***********${userData!.name}');

        if (myMap['data']['document_proof_india'] != null &&
            myMap['data']['document_proof_ksa'] != null) {
          onLoginSuccess(myMap['data']['verification_status'], myMap);
        } else {
          await parser.sharedPreferencesManager
              .putString('register_token', myMap['access_token']);
          Get.bottomSheet(const RegisterDocPending());
        }
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

  void onLoginSuccess(status, myMap) async {
    if (status == 0) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Get.bottomSheet(const RegisterComplited(text: 'Close'),
          isDismissible: false);
      prefs.remove('register_token');
    } else {
      await parser.saveToken('access_token', myMap['access_token']);
      Get.offAllNamed(AppRouter.getBottomNavRoute());
    }
  }
}
