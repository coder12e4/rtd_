import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart ' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rtd_project/controller/profile/profile_controller.dart';
import 'package:rtd_project/helper/router.dart';
import 'package:rtd_project/util/toast.dart';

import '../../backend/model/bloodgroup_model.dart';
import '../../backend/model/profile_model.dart';
import '../../backend/model/states_model.dart';
import '../../backend/model/vehicle_type_model.dart';
import '../../backend/parser/profile/edit_profile_parser.dart';
import '../../util/theme.dart';

class EditProfileController extends GetxController implements GetxService {
  final EditProfileParser parser;
  EditProfileController({required this.parser});
  @override
  void onInit() {
    super.onInit();
    getUserDatas();
    getStates();
    getVehicleType();
    getAllBloodGroup();
  }

  Profile? userData;
  List<AllStatesModel> _allStates = <AllStatesModel>[];
  List<AllStatesModel> get allStates => _allStates;

  List<DropdownMenuItem<AllStatesModel>> _dropdownMenuItems =
      <DropdownMenuItem<AllStatesModel>>[];

  List<DropdownMenuItem<AllStatesModel>> get dropdownMenuItems =>
      _dropdownMenuItems;

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
  AllStatesModel? stateKsa;
  XFile? profileImageFile;
  XFile? docProofIndia;
  XFile? docProofKsa;
  String? statesKsa;
  Data? profileData;

  String? statesName;
  AllStatesModel? selectedItem;
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

  void getStates() async {
    var response = await parser.getStates();
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
      selectedItem != null ? _dropdownMenuItems[0].value : null;
    }
    // log(_allStates.toString());
    update();
  }

  void getVehicleType() async {
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
      vehicleType != null ? _dropdownMenuItems[0].value : null;
    }
    // log(_getAllVehicleType.toString());
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
    // log(_getAllbloodGroup.toString());
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

  void getUserDatas() async {
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
        final imagePath = await urlToFile(userData!.data.profileImage);
        final docIndiaPath = await urlToFile(userData!.data.documentProofIndia);
        final ksaPath = await urlToFile(userData!.data.documentProofKsa);
        profileImageFile = XFile(imagePath.path);
        docProofIndia = XFile(docIndiaPath.path);
        docProofKsa = XFile(ksaPath.path);

        debugPrint(
            'profile image path ********************${profileImageFile!.path}');
        debugPrint(
            'document india path ********************${docProofIndia!.path}');
        debugPrint(
            'document ksa path ********************${docProofKsa!.path}');
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

  // Future<void> updateProfileData() async {
  //   Get.dialog(
  //     SimpleDialog(
  //       children: [
  //         Row(
  //           children: [
  //             const SizedBox(
  //               width: 30,
  //             ),
  //             const CircularProgressIndicator(
  //               color: ThemeProvider.appColor,
  //             ),
  //             const SizedBox(
  //               width: 30,
  //             ),
  //             SizedBox(
  //                 child: Text(
  //               "Please wait".tr,
  //               style: const TextStyle(fontFamily: 'bold'),
  //             )),
  //           ],
  //         )
  //       ],
  //     ),
  //     barrierDismissible: false,
  //   );
  //   var body = {
  //     "name": nameController.text,
  //     "email": mailContoller.text,
  //     "in_mobile": indianMobNumContoller.text,
  //     "ksa_mobile": saudiMobNumContoller.text,
  //     "blood_group": bloodGroup!.id,
  //     "in_address_1": indianAddressContoller1.text,
  //     "in_address_2": indianAddressContoller2.text,
  //     "in_state": selectedItem!.id,
  //     "in_pin": indiaAddPinContoller.text,
  //     "ksa_address_1": ksaAddressContoller1.text,
  //     "ksa_address_2": ksaAddressContoller2.text,
  //     "ksa_state": stateKsa!.id,
  //     "vehicle_number": vehicleNumberContoller.text,
  //     "vehicle_type_id": vehicleType!.id,
  //     "ksa_pin": saudiAddPinContoller.text
  //   };
  //   debugPrint('blood id:${bloodGroup!.id}');
  //   debugPrint('state id:${selectedItem!.id}');
  //   debugPrint('stateksa id:${stateKsa!.id}');
  //   Response response = await parser.updateUserData(body);
  //   debugPrint(response.statusCode.toString());
  //   if (response.statusCode == 200) {
  //     debugPrint(response.body.toString());
  //     if (response.body['status']) {
  //       successToast(response.body['message']);
  //       onProfileEditSuccess();
  //     } else {
  //       showToast(response.body['message']);
  //     }
  //   }
  // }

  Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }

  Future<void> upload(XFile? data1, XFile? data2, XFile? data3) async {
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

    File file1 = File(data1 == null ? profileImageFile!.path : data1.path);
    File file2 = File(data2 == null ? docProofIndia!.path : data2.path);
    File file3 = File(data3 == null ? docProofKsa!.path : data3.path);

    var stream3 = http.ByteStream(DelegatingStream.typed(file1.openRead()));
    var stream4 = http.ByteStream(DelegatingStream.typed(file2.openRead()));
    var stream5 = http.ByteStream(DelegatingStream.typed(file3.openRead()));
    var length3 = await file1.length();
    var length4 = await file2.length();
    var length5 = await file3.length();

    var uri = Uri.parse("http://rtd.canisostudio.com/api/user/update");

    var request = http.MultipartRequest("POST", uri);

    var profileImage = http.MultipartFile('profile_image', stream3, length3,
        filename: basename(file1.path), contentType: MediaType('image', 'png'));
    var docImage1 = http.MultipartFile('in_document', stream4, length4,
        filename: basename(file1.path), contentType: MediaType('image', 'png'));
    var docImage2 = http.MultipartFile('ksa_document', stream5, length5,
        filename: basename(file1.path), contentType: MediaType('image', 'png'));
    String? accessToken =
        parser.sharedPreferencesManager.getString('access_token');
    request.files.add(profileImage);
    request.files.add(docImage1);
    request.files.add(docImage2);

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
    request.fields['ksa_state'] = stateKsa!.id.toString();
    request.fields['vehicle_number'] = vehicleNumberContoller.text;
    request.fields['vehicle_type_id'] = vehicleType!.id.toString();
    request.fields['ksa_pin'] = saudiAddPinContoller.text;

    request.headers.addAll({
      "Accept": "application/json",
      'Authorization': 'Bearer $accessToken',
    });
    var response = await request.send();
    debugPrint(response.statusCode.toString());

    // final respStr = await response.stream.bytesToString();
    response.stream.transform(utf8.decoder).listen((value) {
      debugPrint(value);
      var k = json.decode(value);

      eror message = eror.fromJson(k);
      Get.back();

      if (message.status!) {
        successToast(message.message.toString());
        onProfileEditSuccess();
      } else {
        showToast(k['message'].toString());
        // onLogin();
      }
    });
  }

  void onProfileEditSuccess() {
    final ProfileController profilecontroller = Get.find();
    profilecontroller.getUserDatas();
    Get.delete<EditProfileController>(force: true);
    Get.offNamed(AppRouter.getBottomNavRoute(), arguments: [4]);
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
