// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/backend/model/bloodgroup_model.dart';
import 'package:rtd_project/backend/model/states_model.dart';
import 'package:rtd_project/backend/model/vehicle_type_model.dart';
import 'package:rtd_project/backend/parser/authentication/sighnup_parser.dart';
import 'package:rtd_project/core/constraints/api_urls.dart';
import 'package:rtd_project/util/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/theme.dart';
import '../../view/register_screen/widgets/register_success.dart';

class RegisterController extends GetxController implements GetxService {
  RegisterController({required this.parser});
  final SignUpParser parser;
  final picker = ImagePicker();

  Rx<XFile?> ksaDoc = Rx<XFile?>(null);
  Rx<XFile?> indianDoc = Rx<XFile?>(null);

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      documentsAttached();
      _scrollToSection();
    });

    getStates();
    getKsaStates();
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
  bool isSubmitted = false;
  bool ksaDocSubmitted = false;
  bool indianDocSubmitted = false;
  final gallery = [];
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  bool submitted = false;
  List<AllStatesModel> _allStates = <AllStatesModel>[];
  List<AllStatesModel> get allStates => _allStates;

  List<AllStatesModel> _ksaStates = <AllStatesModel>[];
  List<AllStatesModel> get ksaStates => _ksaStates;

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

  List<DropdownMenuItem<AllStatesModel>> _dropdownKsaItems =
      <DropdownMenuItem<AllStatesModel>>[];
  List<DropdownMenuItem<AllStatesModel>> get dropdownKsaItems =>
      _dropdownKsaItems;
  List<DropdownMenuItem<BloodGroup>> _dropdownMenuItemsBloodgroup =
      <DropdownMenuItem<BloodGroup>>[];
  List<DropdownMenuItem<BloodGroup>> get dropdownMenuItemsBloodgroup =>
      _dropdownMenuItemsBloodgroup;

  List<DropdownMenuItem<VehicleData>> _dropdownMenuItemsVehicleModel =
      <DropdownMenuItem<VehicleData>>[];
  List<DropdownMenuItem<VehicleData>> get dropdownMenuItemsVehicleModel =>
      _dropdownMenuItemsVehicleModel;
  XFile? ksaDocument;
  XFile? indianDocument;
  var isSelected = false.obs;
  var progress;
  void toggleSelection() {
    isSelected.value = !isSelected.value;
  }

  Future<XFile?> pickImage(ImageSource source) async {
    return await picker.pickImage(source: source);
  }

  void updateProgress() {
    updateProgress();

    update();
  }

  void visibityPasswordChange() {
    passwordVisible = !passwordVisible;
    update();
  }

  void visibityConfirmPasswordChange() {
    confirmPasswordVisible = !confirmPasswordVisible;
    update();
  }

  Future<void> onRegister(XFile? profileImage) async {
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

      await upload(
        profileImage,
        nameRegController.text,
        emailRegController.text,
        passwordRegController.text,
        confirmpasswordRegController.text,
        indianMobNumContoller.text,
        ksaMobileNumRegController.text,
        bloodGroup?.id.toString(),
        indianAddressLine1Controller.text,
        indianAddressLine2Controller.text,
        selectedItem?.id.toString(),
        pinController1.text,
        resAddressLine1Controller.text,
        resAddressLine2Controller.text,
        stateKsa?.id.toString(),
        vehicleNumContoller.text,
        vehicleType?.id.toString(),
        pinController2.text,
      );
    } catch (e, stackTrace) {
      log('An error occurred: $e', stackTrace: stackTrace, error: e);
    }
  }

  void getStates() async {
    var response = await parser.getStates('${Constants.getStates}1');
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

  void getKsaStates() async {
    var response = await parser.getStates('${Constants.getStates}2');
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      log(myMap.toString());
      var allStates = myMap['data'];

      _ksaStates = [];

      allStates.forEach((data) {
        AllStatesModel individual = AllStatesModel.fromJson(data);
        _ksaStates.add(individual);
      });

      _dropdownKsaItems = buildDropDownMenuItems(_ksaStates);
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

  void documentsAttached() {
    ksaDocSubmitted =
        parser.sharedPreferencesManager.getBool('ksaDocSubmitted');
    indianDocSubmitted =
        parser.sharedPreferencesManager.getBool('indianDocSubmitted');
    log(ksaDocSubmitted.toString());
    log(indianDocSubmitted.toString());
  }

  void _scrollToSection() {
    String? registerToken =
        parser.sharedPreferencesManager.getString('register_token');
    if (ksaDocSubmitted == true && indianDocSubmitted == true) {
      return;
    }

    if (registerToken != null) {
      isSubmitted = !isSubmitted;
      //   double offset = 1500.0;
      //   _scrollController.animateTo(
      //     offset,
      //     duration: const Duration(milliseconds: 500),
      //     curve: Curves.easeInOut,
      //   );
    }
    update();
  }

  Future<void> uploadKsaDoc(imagePath) async {
    if (imagePath != null) {
      log('ksa************** $ksaDocSubmitted');
      final bool status = await uploadFile(
          Constants.uploadKsaDocument, imagePath, 'document_proof_ksa');
      await parser.sharedPreferencesManager.putBool('ksaDocSubmitted', status);
      ksaDocSubmitted = status;
      log('ksa doc uploaded $ksaDocSubmitted');
    } else {
      showToast('Select Document to Upload');
    }
    registerSuccess();
    update();
  }

  Future<void> uploadIndianDoc(imagePath) async {
    if (imagePath != null) {
      final bool status = await uploadFile(
          Constants.uploadIndianDocument, imagePath, 'document_proof_india');
      log('upload status$status');
      await parser.sharedPreferencesManager
          .putBool('indianDocSubmitted', status)!;
      indianDocSubmitted = status;
      log('india doc uploaded$indianDocSubmitted');
    } else {
      showToast('Select Document to Upload');
    }
    registerSuccess();
    update();
  }

  Future<dynamic> uploadFile(String url, String path, String fileName) async {
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
    var uri = Uri.parse(Constants.baseUrl + url);

    try {
      final accessToken =
          parser.sharedPreferencesManager.getString('register_token');
      var request = http.MultipartRequest('POST', uri);
      debugPrint('url $uri');
      var file1 = await http.MultipartFile.fromPath(fileName, path);
      request.files.add(file1);
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      var response = await request.send();
      debugPrint(response.statusCode.toString());
      var responseData = await response.stream.bytesToString();
      var parsedData = json.decode(responseData);
      debugPrint(' message Data: $parsedData');
      if (parsedData['status'] == true) {
        Get.back();
        successToast(parsedData['message']);
        debugPrint(' Response Data: $responseData');
      }
      if (parsedData['status'] != true) {
        Get.back();
        String errorMessage = '';

        for (var error in parsedData['errors']) {
          errorMessage = "${errorMessage + error['error_name']}\n ";
          log(errorMessage.toString());
          // error += error;
        }

        longToast(errorMessage.toString());
      }

      return parsedData['status'];
    } catch (e) {
      debugPrint('File upload error: $e');
    }
  }
// Example usage:

  Future<void> upload(
    XFile? data,
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
    log('Vehicle data  ${vehicleType?.id}');
    log('$inum: $ksanum');

    var uri = Uri.parse("http://rtd.canisostudio.com/api/register");

    var request = http.MultipartRequest("POST", uri);
    if (data != null) {
      var file = await http.MultipartFile.fromPath('profile_image', data.path);
      request.files.add(file);
    }
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['c_password'] = conPassword;
    request.fields['india_mobile_number'] = inum;
    request.fields['ksa_mobile_number'] = ksanum;
    request.fields['blood_group'] = bloodgroup ?? '';
    request.fields['indian_address_1'] = iaddress1;
    request.fields['indian_address_2'] = iaddress2;
    request.fields['india_state'] = iState ?? '';
    request.fields['india_pin'] = iPin;
    request.fields['ksa_address_1'] = kAddress1;
    request.fields['ksa_address_2'] = kAddress2;
    request.fields['ksa_state'] = kState ?? '';
    request.fields['vehicle_number'] = vehicleNum;
    request.fields['vehicle_type_id'] = vehicletype ?? '';
    request.fields['ksa_pin'] = kPin;
    request.headers.addAll({"Accept": "application/json"});
    var parsedData;
    try {
      var response = await request.send();
      log(response.statusCode.toString());
      log(response.statusCode.toString());

      final responceData = await response.stream.bytesToString();
      parsedData = json.decode(responceData);

      debugPrint(' message Data: $parsedData');
      if (parsedData['status'] == true) {
        Get.back();
        isSubmitted = !isSubmitted;
        await parser.sharedPreferencesManager
            .putString('register_token', parsedData['access_token']);
        successToast(parsedData['message']);
      }
      if (parsedData['status'] != true) {
        Get.back();
        String errorMessage = '';

        for (var error in parsedData['errors']) {
          errorMessage = "${errorMessage + error['error_name']}\n ";
          log(errorMessage.toString());
        }

        longToast(errorMessage.toString());
      }
    } catch (e) {
      debugPrint('Error updating  Data: ${parsedData['message']}');
    }
    update();
  }

  Future<void> registerSuccess() async {
    if (indianDocSubmitted == true && ksaDocSubmitted == true) {
      await Future.delayed(const Duration(seconds: 2));
      final pref = await SharedPreferences.getInstance();
      await pref.remove('indianDocSubmitted');
      await pref.remove('ksaDocSubmitted');
      await pref.remove('register_token');
      Get.bottomSheet(const RegisterComplited(text: 'Continue'),
          isDismissible: false);
    }
  }
}
