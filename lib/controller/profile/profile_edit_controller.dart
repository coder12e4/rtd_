import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/controller/profile/profile_controller.dart';
import 'package:rtd_project/helper/router.dart';
import 'package:rtd_project/util/loading_widget.dart';
import 'package:rtd_project/util/toast.dart';

import '../../backend/model/bloodgroup_model.dart';
import '../../backend/model/profile_model.dart';
import '../../backend/model/states_model.dart';
import '../../backend/model/vehicle_type_model.dart';
import '../../backend/parser/profile/edit_profile_parser.dart';

class EditProfileController extends GetxController implements GetxService {
  final EditProfileParser parser;
  EditProfileController({required this.parser});
  @override
  void onInit() async {
    await getUserDatas();
    await getKsaStates();
    await getStates();
    await getVehicleType();
    await getAllBloodGroup();
    super.onInit();
  }

  Profile? userData;
  List<AllStatesModel> _allStates = <AllStatesModel>[];
  List<AllStatesModel> get allStates => _allStates;

  List<AllStatesModel> _ksaStates = <AllStatesModel>[];
  List<AllStatesModel> get ksaStates => _ksaStates;

  List<DropdownMenuItem<AllStatesModel>> _dropdownMenuItems =
      <DropdownMenuItem<AllStatesModel>>[];

  List<DropdownMenuItem<AllStatesModel>> get dropdownMenuItems =>
      _dropdownMenuItems;

  List<DropdownMenuItem<AllStatesModel>> _dropdownKsaItems =
      <DropdownMenuItem<AllStatesModel>>[];

  List<DropdownMenuItem<AllStatesModel>> get dropdownKsaItems =>
      _dropdownKsaItems;

  List<BloodGroup> _getAllbloodGroup = <BloodGroup>[];
  List<BloodGroup> get getAllbloodGroup => _getAllbloodGroup;

  List<DropdownMenuItem<BloodGroup>> _dropdownMenuItemsBloodgroup =
      <DropdownMenuItem<BloodGroup>>[];
  List<DropdownMenuItem<BloodGroup>> get dropdownMenuItemsBloodgroup =>
      _dropdownMenuItemsBloodgroup;

  List<DropdownMenuItem<VehicleData>> _dropdownMenuItemsVehicleModel =
      <DropdownMenuItem<VehicleData>>[];
  List<DropdownMenuItem<VehicleData>> get dropdownMenuItemsVehicleModel =>
      _dropdownMenuItemsVehicleModel;

  List<VehicleData> _getAllVehicleType = <VehicleData>[];
  List<VehicleData> get getAllVehicleType => _getAllVehicleType;

  VehicleData? vehicleType;
  String? vehicleTypeName;
  BloodGroup? bloodGroup;
  String? bloodGroupName;
  // AllStatesModel? stateKsa;
  XFile? profileImageFile;
  XFile? docProofIndia;
  XFile? docProofKsa;
  String? statesKsa;
  Data? profileData;

  String? statesName;
  AllStatesModel? selectedItem;
  AllStatesModel? selectedKsaItem;
  bool loading = true;
  TextEditingController indianMobNumContoller = TextEditingController();
  TextEditingController saudiMobNumContoller = TextEditingController();
  TextEditingController mailContoller = TextEditingController();
  TextEditingController vehicleNumberContoller = TextEditingController();
  // TextEditingController mail2Contoller =
  //     TextEditingController(text: 'example@gmail.com');
  TextEditingController indianAddressContoller1 = TextEditingController();
  TextEditingController indianAddressContoller2 = TextEditingController();
  TextEditingController indiaAddPinContoller = TextEditingController();
  TextEditingController ksaAddressContoller1 = TextEditingController();
  TextEditingController ksaAddressContoller2 = TextEditingController();
  TextEditingController saudiAddPinContoller = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Future<void> getStates() async {
    var response = await parser.getStates('1');
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      // log(myMap.toString());
      var allStates = myMap['data'];

      _allStates = [];

      allStates.forEach((data) {
        AllStatesModel individual = AllStatesModel.fromJson(data);
        _allStates.add(individual);
      });

      _dropdownMenuItems = buildDropDownMenuItems(_allStates);
      int index = _dropdownMenuItems.indexWhere(
          (element) => element.value?.id == userData?.data.indiaState.id);

      selectedItem = index != -1 ? _dropdownMenuItems[index].value : null;
      // selectedItem != null ? _dropdownMenuItems[0].value : null;
    }
    // log(_allStates.toString());
    update();
  }

  Future<void> getKsaStates() async {
    var response = await parser.getStates('2');
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      debugPrint(myMap.toString());
      var allStates = myMap['data'];

      _ksaStates = [];

      allStates.forEach((data) {
        AllStatesModel individual = AllStatesModel.fromJson(data);
        _ksaStates.add(individual);
      });

      _dropdownKsaItems = buildDropDownMenuItems(_ksaStates);
      int index = _dropdownKsaItems.indexWhere(
          (element) => element.value?.id == userData?.data.ksaState.id);

      selectedKsaItem = index != -1 ? _dropdownKsaItems[index].value : null;
      // selectedKsaItem != null ? _dropdownMenuItems[0].value : null;
    }
    debugPrint(_ksaStates.toString());
    update();
  }

  Future<void> getVehicleType() async {
    var response = await parser.getVehicleType();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      // log(myMap.toString());
      var allvehicleType = myMap['data'];

      _getAllVehicleType = [];

      allvehicleType.forEach((data) {
        VehicleData individual = VehicleData.fromJson(data);
        _getAllVehicleType.add(individual);
      });

      _dropdownMenuItemsVehicleModel =
          buildDropDownMenuItemsVehivleType(_getAllVehicleType);
      int index = _dropdownMenuItemsVehicleModel.indexWhere(
          (element) => element.value?.id == userData?.data.vehicleTypeId);

      vehicleType =
          index != -1 ? _dropdownMenuItemsVehicleModel[index].value : null;
      // vehicleType != null ? _dropdownMenuItems[0].value : null;
    }
    // log(_getAllVehicleType.toString());
    update();
  }

  Future<void> getAllBloodGroup() async {
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
      int index = _dropdownMenuItemsBloodgroup.indexWhere(
          (element) => element.value?.id == userData?.data.bloodGroup);

      bloodGroup =
          index != -1 ? _dropdownMenuItemsBloodgroup[index].value : null;
      // bloodGroup = _dropdownMenuItemsBloodgroup
      //     .firstWhere(
      //       (element) => element.value?.id == userData?.data.bloodGroup,
      //       // orElse: () => ,
      //     )
      //     .value;
      // bloodGroup != null ? _dropdownMenuItemsBloodgroup[0].value : null;
    }

    update();
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

  Future<void> getUserDatas() async {
    final response = await parser.getUserData();

    if (response.statusCode == 200) {
      try {
        // log(response.statusCode.toString());

        Map<String, dynamic> data = Map<String, dynamic>.from(response.body);
        // log(data.toString());

        userData = Profile.fromJson(data);
        indianMobNumContoller.text = userData!.data.indiaMobileNumber;
        saudiMobNumContoller.text = userData!.data.ksaMobileNumber;
        mailContoller.text = userData!.data.email;
        vehicleNumberContoller.text =
            userData!.data.vehicleNumber ?? 'Not Available';
        indianAddressContoller1.text = userData!.data.indianAddress1;
        indianAddressContoller2.text = userData!.data.indianAddress2;
        indiaAddPinContoller.text = userData!.data.indiaPin;
        ksaAddressContoller1.text = userData!.data.ksaAddress1;
        ksaAddressContoller2.text = userData!.data.ksaAddress2;
        saudiAddPinContoller.text = userData!.data.ksaPin;
        nameController.text = userData!.data.name;
        // final imagePath = await urlToFile(userData!.data.profileImage);
        // final docIndiaPath = await urlToFile(userData!.data.documentProofIndia);
        // final ksaPath = await urlToFile(userData!.data.documentProofKsa);
        // profileImageFile = XFile(imagePath.path);
        // docProofIndia = XFile(docIndiaPath.path);
        // docProofKsa = XFile(ksaPath.path);

        // debugPrint(
        //     'profile image path ********************${profileImageFile!.path}');
        // debugPrint(
        //     'document india path ********************${docProofIndia!.path}');
        // debugPrint(
        //     'document ksa path ********************${docProofKsa!.path}');
        // log("Profile Edit Screen :${userData!.data.name.toString()}");
        loading = false;
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint(response.body.toString());
    }
    update();
  }

//   Future<File> urlToFile(String imageUrl) async {
// // generate random number.
//     var rng = Random();
// // get temporary directory of device.
//     Directory tempDir = await getTemporaryDirectory();
// // get temporary path from temporary directory.
//     String tempPath = tempDir.path;
// // create a new file in temporary path with random file name.
//     File file = File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// // call http.get method and pass imageUrl into it to get response.
//     http.Response response = await http.get(Uri.parse(imageUrl));
// // write bodyBytes received in response to file.
//     await file.writeAsBytes(response.bodyBytes);
// // now return the file which is created with random name in
// // temporary directory and image bytes from response is written to // that file.
//     return file;
//   }

  Future<void> upload(XFile? data1, XFile? data2, XFile? data3) async {
    if (vehicleType == null) {
      showToast('Select Vehicle Model');
      return;
    }
    if (bloodGroup == null) {
      showToast('Select blood group');
      return;
    }
    if (selectedKsaItem == null || selectedItem == null) {
      showToast('Select States');
      return;
    }
    loadingWidget();

    String? accessToken =
        parser.sharedPreferencesManager.getString('access_token');

    var uri = Uri.parse("http://rtd.canisostudio.com/api/user/update");
    var request = http.MultipartRequest("POST", uri);
    if (data1 != null) {
      var image1 =
          await http.MultipartFile.fromPath('profile_image', data1.path);
      request.files.add(image1);
    }

    if (data2 != null) {
      var image2 = await http.MultipartFile.fromPath('in_document', data2.path);
      request.files.add(image2);
    }
    if (data3 != null) {
      var image3 =
          await http.MultipartFile.fromPath('ksa_document', data3.path);
      request.files.add(image3);
    }

    request.fields['name'] = nameController.text;
    request.fields['email'] = mailContoller.text;
    request.fields['in_mobile'] = indianMobNumContoller.text;
    request.fields['ksa_mobile'] = saudiMobNumContoller.text;
    request.fields['blood_group'] = bloodGroup!.id.toString();
    request.fields['in_address_1'] = indianAddressContoller1.text;
    request.fields['in_address_2'] = indianAddressContoller2.text;
    request.fields['in_state'] = selectedItem!.id.toString();
    request.fields['in_pin'] = indiaAddPinContoller.text;
    request.fields['ksa_address_1'] = ksaAddressContoller1.text;
    request.fields['ksa_address_2'] = ksaAddressContoller2.text;
    request.fields['ksa_state'] = selectedKsaItem!.id.toString();
    request.fields['vehicle_number'] = vehicleNumberContoller.text;
    request.fields['vehicle_type_id'] = vehicleType!.id.toString();
    request.fields['ksa_pin'] = saudiAddPinContoller.text;

    request.headers.addAll({
      "Accept": "application/json",
      'Authorization': 'Bearer $accessToken',
    });
    var response = await request.send();
    debugPrint(response.statusCode.toString());
    debugPrint(response.statusCode.toString());
    var responseData = await response.stream.bytesToString();
    var parsedData = json.decode(responseData);
    debugPrint(' Response Data:: $parsedData');
    if (parsedData['status'] == true) {
      Get.back();
      successToast(parsedData['message']);
      onProfileEditSuccess();
    }
    if (parsedData['status'] != true) {
      Get.back();
      String errorMessage = '';

      for (var error in parsedData['errors']) {
        errorMessage = "${errorMessage + error['error_name']}\n ";
        debugPrint(errorMessage.toString());
      }

      longToast(errorMessage.toString());
    }
  }

  void onProfileEditSuccess() {
    Get.delete<EditProfileController>(force: true);
    Get.delete<ProfileController>(force: true);
    Get.offNamed(AppRouter.getBottomNavRoute(), arguments: [4]);
  }
}
