import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:rtd_project/backend/model/bloodgroup_model.dart';
import 'package:rtd_project/backend/model/states_model.dart';
import 'package:rtd_project/backend/model/vehicle_type_model.dart';
import 'package:rtd_project/backend/parser/sighnup_parser.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:rtd_project/util/toast.dart';
import 'package:rtd_project/view/register_screen/widgets/register_success.dart';

import '../../helper/router.dart';

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
    getVehicleType();
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
  final TextEditingController indianMobNumContoller = TextEditingController();
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
  final TextEditingController vehicleNumContoller = TextEditingController();
  // XFile? _selectedImage;
  String? cover;
  final gallery = [];
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  List<AllStatesModel> _allStates = <AllStatesModel>[];
  List<AllStatesModel> get allStates => _allStates;

  List<BloodGroup> _getAllbloodGroup = <BloodGroup>[];
  List<BloodGroup> get getAllbloodGroup => _getAllbloodGroup;

  List<VehicleData> _getAllVehicleType = <VehicleData>[];
  List<VehicleData> get getAllVehicleType => _getAllVehicleType;
  String? statesName;
  List<AllStatesModel>? statesList;
  AllStatesModel? selectedItem;

  AllStatesModel? stateKsa;
  String? statesksa;

  String? bloodgroupname;
  List<BloodGroup>? bloodgrouplist;

  String? vehicleTypeName;
  List<VehicleData>? vehicleTypeList;
  VehicleData? vehicleType;
  BloodGroup? bloodGroup;

  List<DropdownMenuItem<AllStatesModel>> _dropdownMenuItems =
      <DropdownMenuItem<AllStatesModel>>[];
  List<DropdownMenuItem<AllStatesModel>> get dropdownMenuItems =>
      _dropdownMenuItems;

  List<DropdownMenuItem<BloodGroup>> _dropdownMenuItemsBloodgroup =
      <DropdownMenuItem<BloodGroup>>[];
  List<DropdownMenuItem<BloodGroup>> get dropdownMenuItemsBloodgroup =>
      _dropdownMenuItemsBloodgroup;

  List<DropdownMenuItem<VehicleData>> _dropdownMenuItemsVehicleModel =
      <DropdownMenuItem<VehicleData>>[];
  List<DropdownMenuItem<VehicleData>> get dropdownMenuItemsVehicleModel =>
      _dropdownMenuItemsVehicleModel;

  var isSelected = false.obs;

  void toggleSelection() {
    isSelected.value = !isSelected.value;
  }

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
  void visibityPasswordChange() {
    passwordVisible = !passwordVisible;
    update();
  }

  void visibityConfirmPasswordChange() {
    confirmPasswordVisible = !confirmPasswordVisible;
    update();
  }

  Future<void> onRegister(XFile file1, XFile file2, XFile profileImage) async {
    try {
      /*if (emailRegController.text == '' ||
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
      }*/
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
      log("state 1${selectedItem!.id.toString()}");
      log('state2${stateKsa!.id.toString()}');
      log('blood group${bloodGroup!.id.toString()}');

      await upload(
        file1,
        file2,
        profileImage,
        nameRegController.text,
        emailRegController.text,
        passwordRegController.text,
        confirmpasswordRegController.text,
        indianMobNumContoller.text,
        ksaMobileNumRegController.text,
        bloodGroup!.id.toString(),
        indianAddressLine1Controller.text,
        indianAddressLine2Controller.text,
        selectedItem!.id.toString(),
        pinController1.text,
        resAddressLine1Controller.text,
        resAddressLine2Controller.text,
        stateKsa!.id.toString(),
        vehicleNumContoller.text,
        vehicleType!.id.toString(),
        pinController2.text,
      );
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

  void getVehicleType() async {
    var response = await parser.getVehicleType();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      log(myMap.toString());
      var allvehicleType = myMap['data'];

      _getAllVehicleType = [];

      allvehicleType.forEach((data) {
        VehicleData individual = VehicleData.fromJson(data);
        _getAllVehicleType.add(individual);
      });

      _dropdownMenuItemsVehicleModel =
          buildDropDownMenuItemsVehivleType(_getAllVehicleType);
      vehicleType != null ? _dropdownMenuItems[0].value : null;
    }
    log(_getAllVehicleType.toString());
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

      _dropdownMenuItemsBloodgroup =
          buildDropDownMenuItemsBloodGroup(_getAllbloodGroup);
      bloodGroup != null ? _dropdownMenuItemsBloodgroup[0].value : null;
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
            textAlign: TextAlign.center,
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

  List<DropdownMenuItem<BloodGroup>> buildDropDownMenuItemsBloodGroup(
      List listItems) {
    List<DropdownMenuItem<BloodGroup>> items = [];
    for (BloodGroup listItem in listItems) {
      items.add(
        DropdownMenuItem(
          value: listItem,
          child: Text(
            listItem.groupName,
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

  List<DropdownMenuItem<VehicleData>> buildDropDownMenuItemsVehivleType(
      List listItems) {
    List<DropdownMenuItem<VehicleData>> items = [];
    for (VehicleData listItem in listItems) {
      items.add(
        DropdownMenuItem(
          value: listItem,
          child: Text(
            listItem.name,
            textAlign: TextAlign.center,
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

  Future<void> upload(
    XFile data1,
    XFile data2,
    XFile data3,
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
    vehicleNum,
    vehicletype,
    kPin,
  ) async {
    log('Vehicle data  ${vehicleType!.id}');
    log('${inum}: $ksanum');
    File file1 = File(data1.path);
    File file2 = File(data2.path);
    File profileImage = File(data3.path);
    var stream3 = http.ByteStream(DelegatingStream.typed(file1.openRead()));
    var length3 = await file1.length();

    var stream4 = http.ByteStream(DelegatingStream.typed(file2.openRead()));
    var length4 = await file2.length();
    var stream5 =
        http.ByteStream(DelegatingStream.typed(profileImage.openRead()));
    var length5 = await profileImage.length();
    var uri = Uri.parse("http://rtd.canisostudio.com/api/register");

    var request = http.MultipartRequest("POST", uri);

    var representative_driving_liesence_image = http.MultipartFile(
        'document_proof_india', stream3, length3,
        filename: basename(file1.path), contentType: MediaType('image', 'png'));
    var representative_company_idcard_image = http.MultipartFile(
        'document_proof_ksa', stream4, length4,
        filename: basename(file2.path), contentType: MediaType('image', 'png'));
    var representative_profile_image = http.MultipartFile(
        'profile_image', stream5, length5,
        filename: basename(profileImage.path),
        contentType: MediaType('image', 'png'));

    request.files.add(representative_driving_liesence_image);
    request.files.add(representative_company_idcard_image);
    request.files.add(representative_profile_image);

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['c_password'] = conPassword;
    request.fields['india_mobile_number'] = inum;
    request.fields['ksa_mobile_number'] = ksanum;
    request.fields['blood_group'] = bloodgroup;
    request.fields['indian_address_1'] = iaddress1;
    request.fields['indian_address_2'] = iaddress2;
    request.fields['india_state'] = iState;
    request.fields['india_pin'] = iPin;
    request.fields['ksa_address_1'] = kAddress1;
    request.fields['ksa_address_2'] = kAddress2;
    request.fields['ksa_state'] = kState;
    request.fields['vehicle_number'] = vehicleNum;
    request.fields['vehicle_type_id'] = vehicletype;
    request.fields['ksa_pin'] = kPin;
    request.headers.addAll({"Accept": "application/json"});
    var response = await request.send();
    log(response.statusCode.toString());
    log(response.statusCode.toString());
    // final respStr = await response.stream.bytesToString();
    response.stream.transform(utf8.decoder).listen((value) {
      log(value);
      var k = json.decode(value);

      eror message = eror.fromJson(k);
      Get.back();

      if (message.status!) {
        successToast(message.message.toString());
        Get.bottomSheet(const RegisterComplited(), isDismissible: false);
      } else {
        showToast(k['message'].toString());
        // onLogin();
      }

      //
      /*if(k['status']==true){
        var message= k['message'];
        (response.statusCode != 200) {
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
      }else{
      }*/
    });
  }

  void onLogin() {
    Get.offNamed(AppRouter.getInitialRoute());
  }
}

class eror {
  String? message;
  bool? status;
  eror({this.message, this.status});
  eror.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
