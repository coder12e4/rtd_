import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/backend/api/handler.dart';
import 'package:rtd_project/backend/model/states_model.dart';
import 'package:rtd_project/backend/parser/sighnup_parser.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:rtd_project/util/toast.dart';
import 'package:rtd_project/view/profile_screen/profile_edit_screen/profile_edit_screen.dart';

class RegisterController extends GetxController implements GetxService {
  RegisterController({required this.parser});
  final SignUpParser parser;
  final picker = ImagePicker();

  Rx<XFile?> ksaDoc = Rx<XFile?>(null);
  Rx<XFile?> indianDoc = Rx<XFile?>(null);

  // @override
  // void onInit() {
  //   getStates();
  //   super.onInit();
  // }

  final TextEditingController nameRegController = TextEditingController();
  final TextEditingController emailRegController = TextEditingController();
  final TextEditingController passwordRegController = TextEditingController();
  final TextEditingController confirmpasswordRegController =
      TextEditingController();

  final TextEditingController mobileNumRegController = TextEditingController();
  final TextEditingController ksaMobileNumRegController =
      TextEditingController();
  final TextEditingController watsappNumRegController = TextEditingController();
/////resisidants adress in ksa/////////
  final TextEditingController resAddressLine1Controller =
      TextEditingController();
  final TextEditingController resAddressLine2Controller =
      TextEditingController();
/////////////////////////emargency contact 1 ksa////////////////////////
  final TextEditingController emName1Controller = TextEditingController();
  final TextEditingController emMobileNum1Controller = TextEditingController();
/////////////////////////emargency contact 2 ksa////////////////////////
  final TextEditingController emName2Controller = TextEditingController();
  final TextEditingController emMObilenum2Controller = TextEditingController();
/////////////////////////indian adress////////////////////////
  final TextEditingController indianAddressLine1Controller =
      TextEditingController();
  final TextEditingController indianAddressLine2Controller =
      TextEditingController();
///////////////////////emarangcy contact india1//////////////////////////////////
  final TextEditingController emIndiaName1Controller = TextEditingController();
  final TextEditingController emIndiaMobile1Controller =
      TextEditingController();
///////////////////////emarangcy contact india2//////////////////////////////////
  final TextEditingController emIndiaName2Controller = TextEditingController();
  final TextEditingController emIndiaMobile2Controller =
      TextEditingController();
///////////////////////last section//////////////////////////////////
  final TextEditingController iqamaNumController = TextEditingController();
  final TextEditingController iqamaexperyDateController =
      TextEditingController();
  final TextEditingController passNumController = TextEditingController();
  final TextEditingController passExperyNumController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController numOfChildrenController = TextEditingController();
  final TextEditingController nomineController = TextEditingController();
  final TextEditingController sponserNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController estNmaeController = TextEditingController();
  final TextEditingController teleNumController = TextEditingController();
  final TextEditingController lastMobileNumController = TextEditingController();
  final TextEditingController sprMobileNumController = TextEditingController();
  final TextEditingController resVehichleNumController =
      TextEditingController();
  final TextEditingController vehMoedelController = TextEditingController();
  final TextEditingController vehTypeController = TextEditingController();
  final TextEditingController vehCompanyController = TextEditingController();
  XFile? _selectedImage;
  String? cover;
  final gallery = [];
  List<States> _allStates = <States>[];
  List<States> get allStates => _allStates;
  Future<XFile?> pickImage(ImageSource source) async {
    return await picker.pickImage(source: source);
  }

  // void selectFromGallery(String kind) async {
  //   _selectedImage = await ImagePicker().pickImage(
  //       source: kind == 'gallery' ? ImageSource.gallery : ImageSource.camera,
  //       imageQuality: 25);
  //   update();
  //   if (_selectedImage != null) {
  //     Get.dialog(
  //         SimpleDialog(
  //           children: [
  //             Row(
  //               children: [
  //                 const SizedBox(
  //                   width: 30,
  //                 ),
  //                 const CircularProgressIndicator(
  //                   color: ThemeProvider.appColor,
  //                 ),
  //                 const SizedBox(
  //                   width: 30,
  //                 ),
  //                 SizedBox(
  //                     child: Text(
  //                   "Please wait".tr,
  //                   style: const TextStyle(fontFamily: 'bold'),
  //                 )),
  //               ],
  //             )
  //           ],
  //         ),
  //         barrierDismissible: false);
  //     Response response = await parser.uploadImage(_selectedImage as XFile);
  //     Get.back();
  //     if (response.statusCode == 200) {
  //       _selectedImage = null;
  //       if (response.body['data'] != null && response.body['data'] != '') {
  //         dynamic body = response.body["data"];
  //         if (body['image_name'] != null && body['image_name'] != '') {
  //           cover = body['image_name'];
  //           debugPrint(cover);
  //           update();
  //         }
  //       }
  //     } else {
  //       ApiChecker.checkApi(response);
  //     }
  //   }
  // }

  // void selectFromGalleryOthers(String kind, int index) async {
  //   _selectedImage = await ImagePicker().pickImage(
  //       source: kind == 'gallery' ? ImageSource.gallery : ImageSource.camera,
  //       imageQuality: 25);
  //   update();
  //   if (_selectedImage != null) {
  //     Get.dialog(
  //         SimpleDialog(
  //           children: [
  //             Row(
  //               children: [
  //                 const SizedBox(
  //                   width: 30,
  //                 ),
  //                 const CircularProgressIndicator(
  //                   color: ThemeProvider.appColor,
  //                 ),
  //                 const SizedBox(
  //                   width: 30,
  //                 ),
  //                 SizedBox(
  //                     child: Text(
  //                   "Please wait".tr,
  //                   style: const TextStyle(fontFamily: 'bold'),
  //                 )),
  //               ],
  //             )
  //           ],
  //         ),
  //         barrierDismissible: false);
  //     Response response = await parser.uploadImage(_selectedImage as XFile);
  //     Get.back();
  //     if (response.statusCode == 200) {
  //       _selectedImage = null;
  //       if (response.body['data'] != null && response.body['data'] != '') {
  //         dynamic body = response.body["data"];
  //         if (body['image_name'] != null && body['image_name'] != '') {
  //           gallery[index] = body['image_name'];
  //           update();
  //         }
  //       }
  //     } else {
  //       ApiChecker.checkApi(response);
  //     }
  //   }
  // }

  Future<void> onRegister(file1, file2) async {
    if (emailRegController.text == '' ||
        emailRegController.text.isEmpty ||
        passwordRegController.text == '' ||
        passwordRegController.text.isEmpty) {
      showToast('All fields are required'.tr);
      return;
    }
    if (!GetUtils.isEmail(passwordRegController.text)) {
      showToast('Email is not valid'.tr);
      return;
    }

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

    var response = await parser.uploadImage(
      file1,
      nameRegController,
      emailRegController,
      passwordRegController,
      confirmpasswordRegController,
      indianMobNumContoller,
      ksaMobileNumRegController,
      1,
      indianAddressLine1Controller,
      indianAddressLine2Controller,
      1,
      '467736',
      resAddressLine1Controller,
      resAddressLine2Controller,
      2,
      '85964',
    );
    Get.back();

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      debugPrint(myMap['user_details']['id'].toString());

      if (myMap['user_details'] != '' && myMap['access_token'] != '') {
        debugPrint(myMap['user']['id'].toString());
        parser.saveToken('access_token', myMap['token']);
        // parser.saveInfo(
        //   myMap['user_details']['id'].toString(),
        //   myMap['user_details']['name'].toString(),
        //   myMap['user_details']['email'].toString(),

        // );
        // var updateParam = {
        //   "id": myMap['user']['id'].toString(),
        //   'fcm_token': parser.getFcmToken(),
        // };
        // await parser.updateProfile(updateParam, myMap['token']);
        // onNavigate();
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

  void getStates() async {
    var response = await parser.getStates();
    if (response.statusCode == 200) {
      // final decodedData = jsonDecode(response.body);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      // log(decodedData.toString());
      var allStates = myMap['data'];

      _allStates = [];
      // _salonCateList = [];
      allStates.forEach((data) {
        States individual = States.fromJson(data);

        _allStates.add(individual);
      });
      // final data = GetAllStates.fromJson(decodedData);
      // List<States> extractedList = data.data;
      // for (States state in extractedList) {
      //   States oneStates = state;
      //   allStates.add(oneStates);
    }
    log(_allStates.toString());
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
