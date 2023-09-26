import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/model/loan/loan_edite_model.dart';
import '../backend/model/loan/loan_type_model.dart';
import '../backend/model/loan/surties_model.dart';
import '../backend/parser/loan_edit_parser.dart';

class LoanEditController extends GetxController implements GetxService {
  final LoanEditParser parser;

  LoanEditController({required this.parser});
  @override
  void onInit() {
    String loanId = Get.arguments[0].toString();
    getSurties();
    getLoanType();
    getLoanDetails(loanId);

    super.onInit();
  }

  Data? loan;
  String? purpose;
  List<SuretiesData>? surties;
  List<int> _addedSurties = <int>[];
  List<int> get addedSurties => _addedSurties;
  List<DropdownMenuItem<Data>> _dropdownMenuLoanType =
      <DropdownMenuItem<Data>>[];
  List<DropdownMenuItem<Data>> get dropdownMenuLoanType =>
      _dropdownMenuLoanType;

  List<Data> _getLoanTypes = <Data>[];
  List<Data> get getLoanTypes => _getLoanTypes;
  bool loading = true;
  LoanData? loanData;
  TextEditingController loanAmountController = TextEditingController();
  Future<void> getLoanType() async {
    Response response = await parser.getLoanTypes();
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> data = Map<String, dynamic>.from(response.body);
        var allLoan = data['data'];
        _getLoanTypes = [];
        allLoan.forEach((data) {
          Data individual = Data.fromJson(data);
          _getLoanTypes.add(individual);
        });
        _dropdownMenuLoanType = buildDropDownMenuItemsLoanType(_getLoanTypes);
        loan != null ? _dropdownMenuLoanType[0].value : null;
        log(_getLoanTypes.toString());
      } catch (e) {
        log(e.toString());
      }
    }

    update();
  }

  Future<void> getSurties() async {
    Response response = await parser.getSurties();
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> data = Map<String, dynamic>.from(response.body);
        var allLoan = data['data'];
        surties = [];
        allLoan.forEach((data) {
          SuretiesData individual = SuretiesData.fromJson(data);
          surties!.add(individual);
        });

        log(surties.toString());
      } catch (e) {
        log(e.toString());
      }
    }
    loading = false;
    update();
  }

  Future<void> getLoanDetails(id) async {
    final body = {"loan_request_id": id};
    Response response = await parser.getLoanDetails(body);
    addedSurties.clear();
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = Map<String, dynamic>.from(response.body);
      loanData = LoanData.fromJson(jsonData);
      for (var element in loanData!.data.sureties) {
        addedSurties.add(element.userId);
      }
      loading = false;
      loanAmountController.text = loanData!.data.loanAmount;
    }
    log(loanData!.toString());
    update();
  }

  List<DropdownMenuItem<Data>> buildDropDownMenuItemsLoanType(List listItems) {
    List<DropdownMenuItem<Data>> items = [];
    for (Data listItem in listItems) {
      items.add(
        DropdownMenuItem(
          value: listItem,
          child: Text(
            listItem.title!,
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

  addSurties(id) {
    if (addedSurties.contains(id)) {
      addedSurties.remove(id);
    } else {
      addedSurties.add(id);
    }
    update();
  }
}
