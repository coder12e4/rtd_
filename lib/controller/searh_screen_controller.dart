import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/loan/loan_edit_controller.dart';
import 'package:rtd_project/controller/loan/loan_screen_controller.dart';

import '../backend/model/loan/surties_model.dart';
import '../backend/parser/search_parser.dart';

class SearchScreenController extends GetxController {
  final SearchScreenParser parser;
  SearchScreenController({required this.parser});

  @override
  void onInit() {
    tappedIndex = Get.arguments[0];
    tappedScreen = Get.arguments[1];
    log(tappedIndex.toString());
    getSurties();
    super.onInit();
  }

  int? tappedIndex;
  bool? tappedScreen;
  bool loading = true;
  // LoanScreenController loanController =
  //     LoanScreenController(parser: Get.find());
  TextEditingController serchController = TextEditingController();
  List<SuretiesData>? surties;
  List<int> _addedSurties = <int>[];
  List<int> get addedSurties => _addedSurties;
  List<SuretiesData>? searchResult = [];
  Future<void> getSurties() async {
    Response response = await parser.getSurties();
    searchResult!.clear();

    if (response.statusCode == 200) {
      log(response.body.toString());
      try {
        Map<String, dynamic> data = Map<String, dynamic>.from(response.body);
        var allLoan = data['data'];
        surties = [];
        allLoan.forEach((data) {
          SuretiesData individual = SuretiesData.fromJson(data);
          surties!.add(individual);
        });
        searchResult = List<SuretiesData>.from(surties ?? []);
        loading = false;
        log(surties.toString());
      } catch (e) {
        log(e.toString());
      }
    }
    // loading = false;
    update();
  }

  addSurties(SuretiesData surety) {
    if (tappedScreen == true) {
      Get.find<LoanEditController>().addSurties(surety, tappedIndex!);
    } else {
      Get.find<LoanScreenController>().addSurties(surety, tappedIndex!);
    }

    update();
  }

  searchSurties(String query) {
    searchResult = surties!
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }
}
