// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/controller/loan/loan_screen_controller.dart';

import '../../backend/model/loan/loan_edite_model.dart';
import '../../backend/model/loan/loan_purpose.dart';
import '../../backend/model/loan/loan_type_model.dart';
import '../../backend/model/loan/surties_model.dart';
import '../../backend/parser/loan/loan_edit_parser.dart';
import '../../core/constraints/api_urls.dart';
import '../../helper/router.dart';
import '../../util/loading_widget.dart';
import '../../util/toast.dart';

class LoanEditController extends GetxController implements GetxService {
  final LoanEditParser parser;

  LoanEditController({required this.parser});
  @override
  void onInit() {
    loanId = Get.arguments[0].toString();
    getLoanDetails(loanId);
    getLoanType();
    super.onInit();
  }

  String? loanId;
  XFile? loanDocument1;
  XFile? loanDocument2;
  XFile? loanDocument3;
  PurposeData? purposeData;
  String? loanAmount;
  LoanPurposeData? loanPurpose;
  List<int> noOfSurties = [];
  Data? loan;
  String? purpose;
  List<bool> isSelected = [];
  List<dynamic> surties = <dynamic>[];
  List<int> _addedSurties = <int>[];
  List<int> get addedSurties => _addedSurties;
  List<DropdownMenuItem<Data>> _dropdownMenuLoanType =
      <DropdownMenuItem<Data>>[];
  List<DropdownMenuItem<Data>> get dropdownMenuLoanType =>
      _dropdownMenuLoanType;
  List<PurposeData> _getPurposeType = <PurposeData>[];
  List<PurposeData> get getPurposeType => _getPurposeType;

  List<DropdownMenuItem<PurposeData>> _dropdownMenuPurpose =
      <DropdownMenuItem<PurposeData>>[];
  List<DropdownMenuItem<PurposeData>> get dropdownMenuPurpose =>
      _dropdownMenuPurpose;

  List<Data> _getLoanTypes = <Data>[];
  List<Data> get getLoanTypes => _getLoanTypes;
  bool loading = true;
  LoanData? loanData;

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

  Future<void> removeLoanDocument(documentId, XFile? selectedDocument) async {
    final body = {
      "loan_request_id": loanId.toString(),
      "loan_document_id": documentId.toString()
    };
    Response response = await parser.removeLoanDocument(body);
    selectedDocument = null;
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> data = Map<String, dynamic>.from(response.body);

        successToast(data['message']);
      } catch (e) {
        log(e.toString());
      }
    } else {
      showToast(response.body['message']);
    }
    getLoanDetails(loanId);
    update();
  }

  Future<void> getLoanPurpose(id) async {
    final body = {"loan_type": id};
    Response response = await parser.getLoanPurpose(body);
    if (response.statusCode == 200) {
      log('Loan purpose :${response.body}');
      try {
        loanPurpose = LoanPurposeData.fromJson(response.body);

        _addedSurties.clear();
        addedSurties.clear();
        surties.clear();
        isSelected.clear();
        noOfSurties.clear();
        for (int i = 1; i <= loanPurpose!.data[0].noOfSureties; i++) {
          noOfSurties.add(1);
          _addedSurties.add(-1);
          surties.add(null);
          isSelected.add(false);
        }
        var allPurpose = response.body["data"];
        // _getPurpose = [];
        // purpose != response.body["data"][0]["title"];
        if (_getPurposeType.isNotEmpty) {
          _getPurposeType.clear();
          _dropdownMenuPurpose.clear();
        }

        allPurpose.forEach((data1) {
          PurposeData individual = PurposeData.fromJson(data1);
          _getPurposeType.add(individual);
        });
        _dropdownMenuPurpose = buildDropDownMenuItemsPurpose(_getPurposeType);
        purposeData = _getPurposeType[0];
        loanAmount = _getPurposeType[0].maxLimit;

        purpose != null ? _dropdownMenuPurpose[0].value : null;
        update();
        log(_getPurposeType.toString());
        log('loan purpose surety : ${noOfSurties}');
      } catch (e, stackTrace) {
        log('loanPurpose catch $e', error: e, stackTrace: stackTrace);
      }
    }
  }

  List<DropdownMenuItem<PurposeData>> buildDropDownMenuItemsPurpose(
      List listItems) {
    List<DropdownMenuItem<PurposeData>> items = [];
    items.clear();
    for (PurposeData listItem in listItems) {
      items.add(
        DropdownMenuItem(
          value: listItem,
          child: Text(
            listItem.purpose,
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

  Future<void> getLoanDetails(id) async {
    _addedSurties.clear();
    addedSurties.clear();
    surties.clear();
    isSelected.clear();
    final body = {"loan_request_id": id};
    Response response = await parser.getLoanDetails(body);

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData =
            Map<String, dynamic>.from(response.body);
        loanData = LoanData.fromJson(jsonData);
        for (var element in loanData!.data.sureties) {
          _addedSurties.add(-1);
          addedSurties.add(element.userId);
          isSelected.add(true);
          surties.add(element);
        }
        // final imagePath =
        //     await parser.urlToFile(loanData!.data.loanDocument[1].file);
        // loanDocument = XFile(imagePath.path);
        loanAmount = loanData!.data.loanAmount;
        loading = false;
      }
    } catch (e, stackTrace) {
      log('loan details catch $e', error: e, stackTrace: stackTrace);
    }

    log(loanData!.toString());
    update();
  }

  void deleteSurety(int index) {
    addedSurties.remove(index);
    surties[index] = null;
    isSelected[index] = !isSelected[index];
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

  Future<void> upload() async {
    loadingWidget();
    if (loanData!.data.loanDocument.length != 3) {
      Get.back();
      showToast('Upload 3 documents');
      return;
    }
    var uri =
        Uri.parse("http://rtd.canisostudio.com/api/user/loan/request/update");

    var request = http.MultipartRequest("POST", uri);

    String? accessToken =
        parser.sharedPreferencesManager.getString('access_token');

    request.fields['loan_request_id'] = loanId!;
    request.fields['loan_type'] = loan!.id.toString();
    request.fields['loan_amount'] = loanAmount!;
    request.fields['loan_purpose'] = purposeData!.id.toString();
    request.fields['sureties'] = addedSurties.toString();

    request.headers.addAll({
      "Accept": "application/json",
      'Authorization': 'Bearer $accessToken',
    });
    // try {
    var response = await request.send();
    debugPrint(response.statusCode.toString());

    var parsedData;
    final responceData = await response.stream.bytesToString();
    parsedData = json.decode(responceData);
    log(parsedData.toString());
    // if (parsedData.sta) {}
    Get.back();
    if (response.statusCode == 200) {
      if (parsedData['status'] == true) {
        successToast(parsedData['message'].toString());
        onLoanEditSuccess();
      } else {
        showToast(parsedData['error']);
      }
    } else if (response.statusCode == 500) {
      showToast("Server error");
    } else {
      String errorMessage = '';
      for (var error in parsedData['errors']) {
        errorMessage = "${errorMessage + error['error_name']}\n ";
        log(errorMessage.toString());
        // error += error;
      }
    }

    // } catch (e, stackTrace) {
    //   log('loan update catch $e', error: e, stackTrace: stackTrace);
    // }
  }
  // Future<void> upload() async {
  //   loadingWidget();
  //   final body = {
  //     'loan_request_id': loanId!,
  //     'loan_type': loan!.id.toString(),
  //     'loan_amount': loanAmount!,
  //     'loan_purpose': purposeData!.id.toString(),
  //     'sureties': addedSurties.toString(),
  //   };
  //   Response response = await parser.updateLoanRequest(body);
  //   try {
  //     Get.back();
  //     log("loan update response :${response.body}");
  //     if (response.statusCode == 200) {
  //       if (response.body["status"] == true) {
  //         successToast(response.body["message"]);
  //       } else {
  //         String errorMessage = '';
  //         for (var error in response.body['errors']) {
  //           errorMessage = "${errorMessage + error['error_name']}\n ";
  //           log(errorMessage.toString());
  //           // error += error;
  //         }
  //         successToast(errorMessage);
  //       }
  //     } else {
  //       successToast(response.body["errors"]);
  //     }
  //   } catch (e, stackTrace) {
  //     log('loan update catch $e', error: e, stackTrace: stackTrace);
  //   }
  // }

  Future<void> uploadLoanDocument(XFile? data) async {
    loadingWidget();
    log('image path : ${data?.path}');
    var uri =
        Uri.parse(Constants.baseUrl + Constants.loanRequestDocumentUpload);
    var request = http.MultipartRequest("POST", uri);
    String? accessToken =
        parser.sharedPreferencesManager.getString('access_token');
    var file =
        await http.MultipartFile.fromPath('loan_document', data?.path ?? '');
    request.files.add(file);
    request.fields['loan_request_id'] = loanId.toString();
    request.headers.addAll({
      "Accept": "application/json",
      'Authorization': 'Bearer $accessToken',
    });
    var response = await request.send();
    log(response.statusCode.toString());
    var parsedData;
    final responceData = await response.stream.bytesToString();
    parsedData = json.decode(responceData);
    Get.back();
    log('loan update response ${parsedData}');
    if (parsedData['status'] == true) {
      log(parsedData.toString());
      getLoanDetails(loanId);
      Get.back();
      successToast('Document uploaded');
    } else {
      showToast(parsedData['message']);
    }
  }

  void updateSelectedImage1(XFile? newImage) {
    loanDocument1 = newImage;
    // image1 = true;
    update();
  }

  void updateSelectedImage2(XFile? newImage) {
    loanDocument2 = newImage;
    // image1 = true;
    update();
  }

  void updateSelectedImage3(XFile? newImage) {
    loanDocument3 = newImage;
    // image1 = true;
    update();
  }

  void onLoanEditSuccess() async {
    Get.delete<LoanScreenController>(force: true);
    Get.offNamed(AppRouter.getBottomNavRoute(), arguments: [2]);
  }
}
