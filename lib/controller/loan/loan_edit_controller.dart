// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

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

import '../../backend/model/loan/loan_edite_model.dart';
import '../../backend/model/loan/loan_type_model.dart';
import '../../backend/model/loan/surties_model.dart';
import '../../backend/parser/loan/loan_edit_parser.dart';
import '../../helper/router.dart';
import '../../util/theme.dart';
import '../../util/toast.dart';
import 'loan_screen_controller.dart';

class LoanEditController extends GetxController implements GetxService {
  final LoanEditParser parser;

  LoanEditController({required this.parser});
  @override
  void onInit() {
    loanId = Get.arguments[0].toString();
    _addedSurties = [-1, -1, -1];
    surties = [null, null, null];
    getLoanType();
    getLoanDetails(loanId);

    super.onInit();
  }

  String? loanId;
  XFile? loanDocument;
  Data? loan;
  String? purpose;
  List<bool> isSelected = [false, false, false];
  List<dynamic> surties = <dynamic>[];
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

  void addSurties(SuretiesData surety, int index) {
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
  // Future<void> getSurties() async {
  //   Response response = await parser.getSurties();
  //   if (response.statusCode == 200) {
  //     try {
  //       Map<String, dynamic> data = Map<String, dynamic>.from(response.body);
  //       var allLoan = data['data'];
  //       surties = [];
  //       allLoan.forEach((data) {
  //         SuretiesData individual = SuretiesData.fromJson(data);
  //         surties!.add(individual);
  //       });
  //
  //       log(surties.toString());
  //     } catch (e) {
  //       log(e.toString());
  //     }
  //   }
  //
  //   update();
  // }

  Future<void> getLoanDetails(id) async {
    final body = {"loan_request_id": id};
    Response response = await parser.getLoanDetails(body);
    addedSurties.clear();
    surties.clear();
    isSelected.clear();
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData =
            Map<String, dynamic>.from(response.body);
        loanData = LoanData.fromJson(jsonData);
        for (var element in loanData!.data.sureties) {
          addedSurties.add(element.userId);
          isSelected.add(true);
          surties.add(element);
        }
        // final imagePath =
        //     await parser.urlToFile(loanData!.data.loanDocument[1].file);
        // loanDocument = XFile(imagePath.path);
        loanAmountController.text = loanData!.data.loanAmount;
        loading = false;
      }
    } catch (e, stackTrace) {
      log('loan details catch $e', error: e, stackTrace: stackTrace);
    }

    log(loanData!.toString());
    update();
  }

  void deleteSurety(int index) {
    addedSurties[index] = -1;
    surties[index] = null;
    isSelected[index] = !isSelected[index];
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

  Future<void> upload(XFile? data1) async {
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

    File file1 = File(data1 == null ? loanDocument!.path : data1.path);

    var stream3 = http.ByteStream(DelegatingStream.typed(file1.openRead()));

    var length3 = await file1.length();

    var uri =
        Uri.parse("http://rtd.canisostudio.com/api/user/loan/request/update");

    var request = http.MultipartRequest("POST", uri);

    var profileImage = http.MultipartFile('loan_document', stream3, length3,
        filename: basename(file1.path), contentType: MediaType('image', 'png'));

    String? accessToken =
        parser.sharedPreferencesManager.getString('access_token');
    request.files.add(profileImage);

    request.fields['loan_request_id'] = loanId!;
    request.fields['loan_type'] = loan!.id.toString();
    request.fields['loan_amount'] = loanAmountController.text;
    request.fields['loan_purpose'] = loan!.id.toString();
    request.fields['sureties'] = addedSurties.toString();

    request.headers.addAll({
      "Accept": "application/json",
      'Authorization': 'Bearer $accessToken',
    });
    var response = await request.send();
    debugPrint(response.statusCode.toString());
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
      onLoanEditSuccess();
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
    // final respStr = await response.stream.bytesToString();
    // response.stream.transform(utf8.decoder).listen((value) {
    //   debugPrint(value);
    //   var k = json.decode(value);
    //
    //   eror message = eror.fromJson(k);
    //   Get.back();
    //
    //   if (message.status!) {
    //     successToast(message.message.toString());
    //     onLoanEditSuccess();
    //   } else {
    //     showToast(k['message'].toString());
    //     // onLogin();
    //   }
    // });
  }

  void onLoanEditSuccess() async {
    Get.delete<LoanScreenController>(force: true);
    Get.offNamed(AppRouter.getBottomNavRoute(), arguments: [2]);
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
