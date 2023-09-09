import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/backend/api/handler.dart';
import 'package:rtd_project/backend/model/bloodgroup_model.dart';
import 'package:rtd_project/backend/model/states_model.dart';
import 'package:rtd_project/backend/parser/sighnup_parser.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:rtd_project/util/toast.dart';
import 'package:rtd_project/view/profile_screen/profile_edit_screen/profile_edit_screen.dart';

class RegisterController extends GetxController implements GetxService {
  RegisterController({required this.parser});
  final SignUpParser parser;
  final picker = ImagePicker();

  Rx<XFile?> ksaDoc = Rx<XFile?>(null);
  Rx<XFile?> indianDoc = Rx<XFile?>(null);

  @override
  void onInit() {
    getStates();
    getAllBloodGroup();

    // _dropdownMenuItems = buildDropDownMenuItems(statesList!);
    // selectedItem != null ? dropdownMenuItems[0].value : null;
    super.onInit();
  }

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
  final TextEditingController pinController1 = TextEditingController();
  final TextEditingController pinController2 = TextEditingController();
  // XFile? _selectedImage;
  String? cover;
  final gallery = [];
  List<AllStatesModel> _allStates = <AllStatesModel>[];
  List<AllStatesModel> get allStates => _allStates;
  List<BloodGroup> _getAllbloodGroup = <BloodGroup>[];
  List<BloodGroup> get getAllbloodGroup => _getAllbloodGroup;
  String? statesName;
  List<AllStatesModel>? statesList;
  AllStatesModel? selectedItem;
  List<DropdownMenuItem<AllStatesModel>> _dropdownMenuItems =
      <DropdownMenuItem<AllStatesModel>>[];
  List<DropdownMenuItem<AllStatesModel>> get dropdownMenuItems =>
      _dropdownMenuItems;
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

  Future<void> onRegister(XFile file1, XFile file2) async {
    try {
      if (emailRegController.text == '' ||
          emailRegController.text.isEmpty ||
          passwordRegController.text == '' ||
          passwordRegController.text.isEmpty ||
          nameRegController.text == '' ||
          nameRegController.text.isEmpty ||
          indianAddressLine1Controller.text == '' ||
          indianAddressLine1Controller.text.isEmpty ||
          indianAddressLine2Controller.text == '' ||
          indianAddressLine2Controller.text.isEmpty ||
          resAddressLine1Controller.text == '' ||
          resAddressLine1Controller.text.isEmpty ||
          resAddressLine2Controller.text == '' ||
          resAddressLine2Controller.text.isEmpty ||
          indianMobNumContoller.text == '' ||
          indianMobNumContoller.text.isEmpty ||
          ksaMobileNumRegController.text == '' ||
          ksaMobileNumRegController.text.isEmpty ||
          pinController1.text == '' ||
          pinController1.text.isEmpty ||
          pinController2.text == '' ||
          pinController2.text.isEmpty) {
        showToast('All fields are required'.tr);
        return;
      }
      if (!GetUtils.isEmail(emailRegController.text)) {
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
        file2,
        nameRegController.text,
        emailRegController.text,
        passwordRegController.text,
        confirmpasswordRegController.text,
        indianMobNumContoller.text,
        ksaMobileNumRegController.text,
        '1',
        indianAddressLine1Controller.text,
        indianAddressLine2Controller.text,
        '1',
        pinController1.text,
        resAddressLine1Controller.text,
        resAddressLine2Controller.text,
        '2',
        pinController2.text,
      );

      Get.back();
      if (response.statusCode != 200) {
        showToast('Server error ${response.statusCode}'.tr);
      }
      log('got response');
      log('Status Code ${response.statusCode}');
      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        debugPrint(myMap['user_details']['id'].toString());

        if (myMap['user_details'] != '' && myMap['access_token'] != '') {
          debugPrint(myMap['user']['id'].toString());
          parser.saveToken('access_token', myMap['token']);
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
    } catch (e) {
      // Handle any exceptions that occur during the execution of the function.
      log('An error occurred: $e');
      // You can display an error message to the user or take any necessary actions.
    }
  }

  void getStates() async {
    var response = await parser.getStates();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      log(myMap.toString());
      var allStates = myMap['data'];

      _allStates = [];

      allStates.forEach((data) {
        AllStatesModel individual = AllStatesModel.fromJson(data);

        _allStates.add(individual);
      });

      _dropdownMenuItems = buildDropDownMenuItems(_allStates);
      selectedItem != null ? _dropdownMenuItems[0].value : null;
    }
    log(_allStates.toString());
    update();
  }

  void getAllBloodGroup() async {
    var response = await parser.getBloodGroup();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

      var allbloodGroup = myMap['data'];

      _getAllbloodGroup = [];

      allbloodGroup.forEach((data) {
        BloodGroup individual = BloodGroup.fromJson(data);

        _getAllbloodGroup.add(individual);
      });
    }
    log(_getAllbloodGroup.toString());
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  List<DropdownMenuItem<AllStatesModel>> buildDropDownMenuItems(
      List listItems) {
    List<DropdownMenuItem<AllStatesModel>> items = [];
    for (AllStatesModel listItem in listItems) {
      items.add(
        DropdownMenuItem(
          value: listItem,
          child: Text(
            listItem.stateName,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: .1,
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    return items;
  }
}
