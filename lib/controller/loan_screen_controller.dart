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

import '../backend/model/loan/loan_request_model.dart';
import '../backend/model/loan/loan_type_model.dart';
import '../backend/model/loan/surties_model.dart';
import '../backend/parser/loan_screen_parser.dart';
import '../util/theme.dart';
import '../util/toast.dart';

class LoanScreenController extends GetxController {
  final LoanScreenParser parser;
  LoanScreenController({required this.parser});
  @override
  void onInit() {
    getLoanType();
    getSurties();
    getLoanRequestData();

    super.onInit();
  }

  bool loading = true;
  Data? loan;
  TextEditingController loanAmountController = TextEditingController();
  List<LoanData> _loanData = <LoanData>[];
  List<LoanData> get loanData => _loanData;
  List<SuretiesData>? surties;
  List<int> _addedSurties = <int>[];
  List<int> get addedSurties => _addedSurties;
  List<Data> _getLoanTypes = <Data>[];
  List<Data> get getLoanTypes => _getLoanTypes;
  List<DropdownMenuItem<Data>> _dropdownMenuLoanType =
      <DropdownMenuItem<Data>>[];
  List<DropdownMenuItem<Data>> get dropdownMenuLoanType =>
      _dropdownMenuLoanType;
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

  addSurties(id) {
    if (addedSurties.contains(id)) {
      addedSurties.remove(id);
    } else {
      addedSurties.add(id);
    }
    update();
  }

  Future<void> upload(
    XFile data1,
    loanTypeId,
    loanPurpose,
    surties,
  ) async {
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
    File file1 = File(data1.path);

    var stream3 = http.ByteStream(DelegatingStream.typed(file1.openRead()));
    var length3 = await file1.length();

    var uri =
        Uri.parse("http://rtd.canisostudio.com/api/user/loan/request/create");

    var request = http.MultipartRequest("POST", uri);

    var loanDocument = http.MultipartFile('loan_document', stream3, length3,
        filename: basename(file1.path), contentType: MediaType('image', 'png'));
    String? accessToken =
        parser.sharedPreferencesManager.getString('access_token');
    request.files.add(loanDocument);

    request.fields['sureties'] = surties.toString();
    request.fields['loan_purpose'] = loanPurpose.toString();
    request.fields['loan_amount'] = loanAmountController.text;
    request.fields['loan_type'] = loanTypeId.toString();

    request.headers.addAll({
      "Accept": "application/json",
      'Authorization': 'Bearer $accessToken',
    });
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
        _addedSurties.clear();

        successToast(message.message.toString());
        getLoanRequestData();
      } else {
        showToast(k['message'].toString());
        // onLogin();
      }
    });
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
