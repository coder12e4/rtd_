import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtd_project/backend/model/books/service_member_details.dart';
import 'package:rtd_project/backend/model/books/services_model.dart';
import '../../backend/model/books/books_member_model.dart';
import '../../backend/model/books/service_member_list.dart';
import '../../backend/model/states_model.dart';
import '../../backend/parser/book/books_parser.dart';
import '../../core/constraints/api_urls.dart';

class BookScreenController extends GetxController {
  final BookScreenParser parser;
  BookScreenController({required this.parser});
  @override
  void onInit() {
    getStates();
    getServices();
    super.onInit();
  }

  TextEditingController memberSearchController = TextEditingController();
  TextEditingController serviceSearchController = TextEditingController();
  AllStatesModel? selectedItem;
  ServiceData? selectedService;
  AllStatesModel? selectedState;
  ServicesMemberList? servicesMemberList;
  MemberDetails? memberDetails;
  bool loading = false;
  bool initial = true;
  bool serviceLoading = true;

  String? statesName;
  String? serviceName;
  String? serviceStateName;
  List<AllStatesModel> _allStates = <AllStatesModel>[];
  List<AllStatesModel> get allStates => _allStates;

  List<ServiceData> _allServices = <ServiceData>[];
  List<ServiceData> get allServices => _allServices;

  List<AllStatesModel> _serviceStates = <AllStatesModel>[];
  List<AllStatesModel> get serviceStates => _serviceStates;

  List<MemberData> _memberList = <MemberData>[];
  List<MemberData> get memberList => _memberList;

  List<DropdownMenuItem<AllStatesModel>> _dropdownMenuItems =
      <DropdownMenuItem<AllStatesModel>>[];

  List<DropdownMenuItem<ServiceData>> _serviceMenuItems =
      <DropdownMenuItem<ServiceData>>[];

  List<DropdownMenuItem<AllStatesModel>> _dropdownServiceItems =
      <DropdownMenuItem<AllStatesModel>>[];

  List<DropdownMenuItem<AllStatesModel>> get dropdownMenuItems =>
      _dropdownMenuItems;

  List<DropdownMenuItem<AllStatesModel>> get dropdownServiceItems =>
      _dropdownServiceItems;

  List<DropdownMenuItem<ServiceData>> get serviceMenuItems => _serviceMenuItems;

  Future<void> getStates() async {
    var response = await parser.getStates('${Constants.getStates}2');
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      log(myMap.toString());
      var allStates = myMap['data'];

      _allStates = [];
      _serviceStates = [];
      allStates.forEach((data) {
        AllStatesModel individual = AllStatesModel.fromJson(data);
        _allStates.add(individual);
        _serviceStates.add(individual);
      });

      _dropdownMenuItems = buildDropDownMenuItems(_allStates);
      _dropdownServiceItems = buildDropDownMenuItems(_serviceStates);
      selectedItem != null ? _dropdownMenuItems[0].value : null;
      selectedState != null ? _dropdownServiceItems[0].value : null;
    }
    log(_allStates.toString());
    update();
  }

  Future<void> getServices() async {
    var response = await parser.getServices();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      log(myMap.toString());
      var allServices = myMap['data'];

      _allServices = [];
      allServices.forEach((data) {
        ServiceData individual = ServiceData.fromJson(data);
        _allServices.add(individual);
      });

      _serviceMenuItems = buildServiceDropDownItems(_allServices);

      selectedService != null ? _dropdownMenuItems[0].value : null;
    }
    log(_allServices.toString());
    update();
  }

  Future<void> searchBookMember(String? query) async {
    initial = false;
    if (_memberList.isNotEmpty) {
      _memberList.clear();
    }

    try {
      var response = await parser.searchBookMember(selectedItem!.id, query);
      if (response.statusCode == 200) {
        loading = false;
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        log("${response.body}");
        var allMembers = myMap['data'];

        allMembers.forEach((data) {
          MemberData individual = MemberData.fromJson(data);
          _memberList.add(individual);
        });
      }
      update();
    } catch (e, stracktrace) {
      log(
        'search member catch $e',
        error: e,
        stackTrace: stracktrace,
      );
    }

    log(_allStates.toString());
  }

  void searchServiceList(String? query) {
    if (selectedState?.id != null && selectedService?.id != null) {
      getServiceMemberList(query);
    }
  }

  Future<void> getServiceMemberList(String? query) async {
    serviceLoading = true;
    update();
    log('selected state id ${selectedState!.id}');
    log('selected service id ${selectedService!.id}');

    try {
      var response = await parser.getServiceMemberList(
        stateId: selectedState!.id,
        serviceId: selectedService!.id,
        query: query ?? '',
      );
      if (response.statusCode == 200) {
        //Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        var k = jsonDecode(response.body);
        servicesMemberList = ServicesMemberList.fromJson(k);
        serviceLoading = !serviceLoading;
        initial = false;
        log("${response.body}");
      }
      update();
    } catch (e, stackTrace) {
      log(
        'search member catch $e',
        error: e,
        stackTrace: stackTrace,
      );
    }

    log(_allStates.toString());
  }

  List<DropdownMenuItem<ServiceData>> buildServiceDropDownItems(
      List listItems) {
    List<DropdownMenuItem<ServiceData>> items = [];
    for (ServiceData listItem in listItems) {
      items.add(
        DropdownMenuItem(
          value: listItem,
          child: Center(
            child: Text(
              listItem.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  letterSpacing: .1,
                  fontWeight: FontWeight.w500),
            ),
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
          child: Center(
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
        ),
      );
    }

    return items;
  }
}
