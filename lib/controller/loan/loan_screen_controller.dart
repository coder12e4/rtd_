import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../backend/model/loan/loan_request_model.dart';
import '../../backend/model/loan/loan_type_model.dart';
import '../../backend/model/loan/surties_model.dart';
import '../../backend/parser/loan/loan_screen_parser.dart';
import '../../util/theme.dart';
import '../../util/toast.dart';

class LoanScreenController extends GetxController {
  final LoanScreenParser parser;
  LoanScreenController({required this.parser});
  @override
  void onInit() {
    _addedSurties = [-1, -1, -1];
    surties = [null, null, null];
    getLoanType();

    getLoanRequestData();

    super.onInit();
  }

  bool loading = true;
  Data? loan;
  TextEditingController loanAmountController = TextEditingController();
  List<LoanData> _loanData = <LoanData>[];
  List<LoanData> get loanData => _loanData;
  List<SuretiesData?> surties = <SuretiesData?>[];
  List<int> _addedSurties = <int>[];
  List<int> get addedSurties => _addedSurties;
  List<Data> _getLoanTypes = <Data>[];
  List<Data> get getLoanTypes => _getLoanTypes;
  List<DropdownMenuItem<Data>> _dropdownMenuLoanType =
      <DropdownMenuItem<Data>>[];
  List<DropdownMenuItem<Data>> get dropdownMenuLoanType =>
      _dropdownMenuLoanType;
  List<bool> isSelected = [false, false, false];
  LoanType? loanType;
  String? purpose;
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

  Future<void> getLoanRequestData() async {
    Response response = await parser.getLoanRequestData();
    if (response.statusCode == 200) {
      loanData.clear();
      loading = true;

      update();

      try {
        Map<String, dynamic> jsonData =
            Map<String, dynamic>.from(response.body);
        List allData = jsonData['data'];
        for (var element in allData) {
          LoanData individual = LoanData.fromJson(element);
          loanData.add(individual);
        }
      } catch (e) {
        log('Loan request data error $e');
      }
    }
    loading = false;
    update();
  }

  Future<void> cancelLoanRequest(id) async {
    final body = {"loan_request_id": id.toString()};
    Response response = await parser.cancelLoanRequest(body);
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonData =
            Map<String, dynamic>.from(response.body);
        successToast(jsonData['message']);
        await getLoanRequestData();
      } catch (e) {
        log(e.toString());
      }
    }
    update();
    log(response.body.toString());
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

  void deleteSurety(int index) {
    addedSurties[index] = -1;
    surties[index] = null;
    isSelected[index] = !isSelected[index];
    update();
  }

  addSurties(SuretiesData surety, int index) {
    if (addedSurties.contains(surety.id)) {
      showToast('Surety already selected');
      return;
    }
    if (!addedSurties.contains(surety.id)) {
      isSelected[index] = !isSelected[index];
      addedSurties[index] = surety.id;
      surties[index] = surety;
      log(addedSurties.toString());
      log('selected surty$surties');
      Get.back();
      successToast('Surety selected');

      update();
    }
  }

  Future<void> upload(
    XFile? data1,
    loanTypeId,
    loanPurpose,
    sureties,
  ) async {
    if (data1 == null) {
      showToast('Select document');
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
    var uri =
        Uri.parse("http://rtd.canisostudio.com/api/user/loan/request/create");
    var request = http.MultipartRequest("POST", uri);
    var file1 =
        await http.MultipartFile.fromPath('loan_document', data1?.path ?? '');
    request.files.add(file1);

    String? accessToken =
        parser.sharedPreferencesManager.getString('access_token');

    request.fields['sureties'] = sureties.toString();
    request.fields['loan_purpose'] = loanPurpose.toString();
    request.fields['loan_amount'] = loanAmountController.text;
    request.fields['loan_type'] = loanTypeId.toString();

    request.headers.addAll({
      "Accept": "application/json",
      'Authorization': 'Bearer $accessToken',
    });
    var response = await request.send();
    log(response.statusCode.toString());

    // final respStr = await response.stream.bytesToString();
    var parsedData;
    final responceData = await response.stream.bytesToString();
    parsedData = json.decode(responceData);
    log(parsedData.toString());
    if (parsedData['status'] == true) {
      Get.back();
      _addedSurties = [-1, -1, -1];
      surties = [null, null, null];
      isSelected = [false, false, false];
      successToast(parsedData['message'].toString());
      getLoanRequestData();
    } else {
      Get.back();
      String errorMessage = '';
      for (var error in parsedData['errors']) {
        errorMessage = errorMessage + error['error_name'] + "\n ";
        log(errorMessage.toString());
        // error += error;
      }
      showToast(errorMessage);
    }
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
