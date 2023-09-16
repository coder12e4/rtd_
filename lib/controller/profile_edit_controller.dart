import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/model/bloodgroup_model.dart';
import '../backend/model/profile_model.dart';
import '../backend/model/states_model.dart';
import '../backend/parser/edit_profile_parser.dart';

class EditProfileController extends GetxController implements GetxService {
  final EditProfileParser parser;
  EditProfileController({required this.parser});
  @override
  void onInit() {
    getProfileData();
    getStates();
    getAllBloodGroup();
    super.onInit();
    indianMobNumContoller.text = profileData!.indiaMobileNumber;
    saudiMobNumContoller.text = profileData!.ksaMobileNumber;
    mailContoller.text = profileData!.email;
    indianAddressContoller1.text = profileData!.indianAddress1;
    indianAddressContoller2.text = profileData!.indianAddress2;
    indiaAddPinContoller.text = profileData!.indiaPin;
    ksaAddressContoller1.text = profileData!.ksaAddress1;
    ksaAddressContoller2.text = profileData!.ksaAddress2;
    saudiAddPinContoller.text = profileData!.ksaPin;
  }

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

  BloodGroup? bloodGroup;
  String? bloodGroupName;
  AllStatesModel? stateKsa;

  String? statesKsa;
  Data? profileData;

  String? statesName;
  AllStatesModel? selectedItem;
  bool loading = true;
  TextEditingController indianMobNumContoller = TextEditingController();
  TextEditingController saudiMobNumContoller = TextEditingController();
  TextEditingController mailContoller = TextEditingController();
  // TextEditingController mail2Contoller =
  //     TextEditingController(text: 'example@gmail.com');
  TextEditingController indianAddressContoller1 = TextEditingController();
  TextEditingController indianAddressContoller2 = TextEditingController();
  TextEditingController indiaAddPinContoller = TextEditingController();
  TextEditingController ksaAddressContoller1 = TextEditingController();
  TextEditingController ksaAddressContoller2 = TextEditingController();
  TextEditingController saudiAddPinContoller = TextEditingController();

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

      _dropdownMenuItemsBloodgroup =
          buildDropDownMenuItemsBloodGroup(_getAllbloodGroup);
      bloodGroup != null ? _dropdownMenuItemsBloodgroup[0].value : null;
    }
    log(_getAllbloodGroup.toString());
    update();
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

  void getProfileData() {
    final data = parser.sharedPreferencesManager.getString('profile_data');
    Map<String, dynamic> map = jsonDecode(data!);
    profileData = Data.fromJson(map);

    log("profile data${profileData!.name}");
    loading = false;
  }

  Future<void> updateProfileData() async {
    var body = {
      "name": profileData!.name,
      "email": mailContoller.text,
      "india_mobile_number": indianMobNumContoller.text,
      "ksa_mobile_number": saudiMobNumContoller.text,
      "blood_group": bloodGroup!.id.toString(),
      "indian_address_1": indianAddressContoller1.text,
      "indian_address_2": indianAddressContoller2.text,
      "india_state": selectedItem!.id,
      "india_pin": indiaAddPinContoller.text,
      "ksa_address_1": ksaAddressContoller1.text,
      "ksa_address_2": ksaAddressContoller2.text,
      "ksa_state": stateKsa!.id,
      "ksa_pin": saudiAddPinContoller.text,
    };
    log('blood id:${bloodGroup!.id}');
    log('state id:${selectedItem!.id}');
    log('stateksa id:${stateKsa!.id}');
    Response response = await parser.updateUserData(body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log(response.body.toString());
    }
  }
}
