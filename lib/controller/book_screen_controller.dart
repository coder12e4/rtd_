import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/model/books/books_member_model.dart';
import '../backend/model/states_model.dart';
import '../backend/parser/books_parser.dart';
import '../core/constraints/api_urls.dart';

class BookScreenController extends GetxController {
  final BookScreenParser parser;
  BookScreenController({required this.parser});
  @override
  void onInit() {
    getStates();
    super.onInit();
  }

  AllStatesModel? selectedItem;
  bool loading = false;
  bool memberEmpty = false;
  String? statesName;
  List<AllStatesModel> _allStates = <AllStatesModel>[];
  List<AllStatesModel> get allStates => _allStates;

  List<MemberData> _memberList = <MemberData>[];
  List<MemberData> get memberList => _memberList;

  List<DropdownMenuItem<AllStatesModel>> _dropdownMenuItems =
      <DropdownMenuItem<AllStatesModel>>[];
  List<DropdownMenuItem<AllStatesModel>> get dropdownMenuItems =>
      _dropdownMenuItems;

  void getStates() async {
    var response = await parser.getStates('${Constants.getStates}2');
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

  void searchBookMember() async {
    loading = true;
    update();
    log('selected state id ${selectedItem!.id}');
    _memberList.clear();
    final body = {
      "state": selectedItem!.id.toString(),
    };
    try {
      var response = await parser.searchBookMember(body);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        log(myMap.toString());
        var allMembers = myMap['data'];

        allMembers.forEach((data) {
          MemberData individual = MemberData.fromJson(data);
          _memberList.add(individual);
        });
        _memberList.isEmpty ? memberEmpty = true : false;
        loading = !loading;
      }
    } catch (e, stracktrace) {
      log(
        'search member catch $e',
        error: e,
        stackTrace: stracktrace,
      );
    }

    log(_allStates.toString());
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
}
