// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/controller/loan/loan_screen_controller.dart';

import '../../backend/model/loan/loan_document.dart';
import '../../backend/model/loan/loan_edite_model.dart';
import '../../backend/model/loan/loan_purpose.dart';
import '../../backend/model/loan/loan_type_model.dart';
import '../../backend/parser/loan/loan_edit_parser.dart';
import '../../core/constraints/api_urls.dart';
import '../../helper/router.dart';
import '../../util/loading_widget.dart';
import '../../util/toast.dart';

class LoanEditController extends GetxController implements GetxService {
  final LoanEditParser parser;

  LoanEditController({required this.parser});
  @override
  void onInit() async {
    loanId = Get.arguments[0].toString();
    await getLoanDetails(loanId);
    await getLoanType();
    super.onInit();
  }

  int loanDocumentCount = 0;
  int loanSuretyCount = 0;
  String? loanId;
  XFile? loanDocument1;
  XFile? loanDocument2;
  XFile? loanDocument3;
  PurposeData? purposeData;
  LoanEditDocument? loanEditDocument;
  String? loanAmount;
  LoanPurposeData? loanPurpose;
  List<int> noOfSurties = [];
  Data? loan;
  String? purpose;
  List<bool> isSelected = [];
  List<dynamic> surties = <dynamic>[];
  final List<int> _addedSurties = <int>[];
  List<int> get addedSurties => _addedSurties;
  List<DropdownMenuItem<Data>> _dropdownMenuLoanType =
      <DropdownMenuItem<Data>>[];
  List<DropdownMenuItem<Data>> get dropdownMenuLoanType =>
      _dropdownMenuLoanType;
  final List<PurposeData> _getPurposeType = <PurposeData>[];
  List<PurposeData> get getPurposeType => _getPurposeType;

  List<DropdownMenuItem<PurposeData>> _dropdownMenuPurpose =
      <DropdownMenuItem<PurposeData>>[];
  List<DropdownMenuItem<PurposeData>> get dropdownMenuPurpose =>
      _dropdownMenuPurpose;

  final List<Data> _getLoanTypes = <Data>[];
  List<Data> get getLoanTypes => _getLoanTypes;
  bool loading = true;
  LoanData? loanData;

  Future<void> getLoanType() async {
    try {
      Response response = await parser.getLoanTypes();

      if (response.statusCode == 200) {
        Map<String, dynamic> data = Map<String, dynamic>.from(response.body);
        var allLoan = data['data'];

        _getLoanTypes.clear();

        for (var loanData in allLoan) {
          _getLoanTypes.add(Data.fromJson(loanData));
        }

        _dropdownMenuLoanType = buildDropDownMenuItemsLoanType(_getLoanTypes);

        // int index = _dropdownMenuLoanType.indexWhere(
        //     (element) => element.value?.id == loanData?.data.loanType.id);
        //
        // loan = index != -1 ? _dropdownMenuLoanType[index].value : null;
        loan = _dropdownMenuLoanType
            .firstWhere(
              (element) => element.value?.id == loanData?.data.loanType.id,
            )
            .value;
        log('loan type  ${loan?.title}');
        log('loan id ${loan?.id}');
        if (loan != null) {
          await getLoanPurpose(loan?.id, 1);
        }
        //

        log("loan type ${loan?.title}");
        log(_getLoanTypes.toString());
      }
    } catch (e, stackTrace) {
      log("loan type catch $e", error: e, stackTrace: stackTrace);
    }

    update();
  }

  Future<void> getLoanDocuments() async {
    final body = {
      "loan_request_id": loanId.toString(),
    };
    Response response = await parser.getLoanDocuments(body);
    log("loan document response ${response.body}");
    if (response.statusCode == 200) {
      try {
        loanEditDocument = LoanEditDocument.fromJson(response.body);
      } catch (e, stackTrace) {
        log("Loan document catch $e", error: e, stackTrace: stackTrace);
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
    getLoanDocuments();
    update();
  }

  Future<void> getLoanPurpose(id, int value) async {
    loadingWidget();
    purpose = null;
    purposeData = null;
    final body = {"loan_type": id};
    Response response = await parser.getLoanPurpose(body);
    if (response.statusCode == 200) {
      log('Loan purpose :${response.body}');
      try {
        loanPurpose = LoanPurposeData.fromJson(response.body);

        if (value == 2) {
          surties.clear();
          isSelected.clear();
          noOfSurties.clear();
          addedSurties.clear();
          loanSuretyCount = 0;
          for (int i = 1; i <= loanPurpose!.data[0].noOfSureties; i++) {
            noOfSurties.add(1);
            surties.add(null);
            isSelected.add(false);
          }
        }

        var allPurpose = response.body["data"];

        if (_getPurposeType.isNotEmpty) {
          _getPurposeType.clear();
          _dropdownMenuPurpose.clear();
        }

        allPurpose.forEach((data1) {
          PurposeData individual = PurposeData.fromJson(data1);
          _getPurposeType.add(individual);
        });
        _dropdownMenuPurpose = buildDropDownMenuItemsPurpose(_getPurposeType);

        if (value == 1) {
          // int purposeIndex = _dropdownMenuPurpose.indexWhere(
          //     (element) => element.value?.id == loanData?.data.loanPurposeId);
          // purposeData = purposeIndex != -1
          //     ? _dropdownMenuPurpose[purposeIndex].value
          //     : null;
          purposeData = _dropdownMenuPurpose
              .firstWhere((element) =>
                  element.value?.id == loanData?.data.loanPurposeId)
              .value;
          loanAmount = purposeData?.maxLimit;
          log('loan purpose  ${purposeData?.purpose}');
        }
        if (value == 2) {
          purposeData = dropdownMenuPurpose[0].value;

          loanAmount = purposeData?.maxLimit;
          purpose != null ? _dropdownMenuPurpose[0].value : null;
        }
        Get.back();
        update();
        log(_getPurposeType.toString());
        log('loan purpose surety : $noOfSurties');
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
        purpose = loanData?.data.loanPurpose.purpose;
        // loanPurpose=loanData?.data.loanType;
        for (Surety element in loanData!.data.sureties) {
          addedSurties.add(element.id);
          isSelected.add(true);
          surties.add(element);
          loanSuretyCount++;
        }
        loanAmount = loanData!.data.loanAmount;
        await getLoanDocuments();
        loading = false;
      }
    } catch (e, stackTrace) {
      log('loan details catch $e', error: e, stackTrace: stackTrace);
    }

    update();
  }

  void deleteSurety(int index, surety) {
    addedSurties.remove(surety.id);
    surties[index] = null;
    isSelected[index] = !isSelected[index];
    loanSuretyCount--;
    log("added sureties ${addedSurties.length}");
    update();
  }

  void addSurties(surety, int index) {
    if (addedSurties.contains(surety.id)) {
      showToast('Surety already selected');
      return;
    }
    if (!addedSurties.contains(surety.id)) {
      isSelected[index] = !isSelected[index];
      addedSurties.add(surety.id);
      surties[index] = surety;
      loanSuretyCount++;
      log(_addedSurties.toString());
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

  void updateLoanSuretyCount(PurposeData purposeData) {
    addedSurties.clear();
    surties.clear();
    isSelected.clear();
    noOfSurties.clear();
    for (int i = 1; i <= purposeData.noOfSureties; i++) {
      noOfSurties.add(1);
      // addedSurties.add(-1);
      surties.add(null);
      isSelected.add(false);
    }
  }

  Future<void> upload() async {
    if (purpose == null) {
      showToast('Select Loan  Purpose');
      return;
    }
    if (loan == null) {
      showToast('Select Loan Type');
      return;
    }
    // if (loanDocumentCount < 3) {
    //   showToast("Loan request must need three documents");
    //   return;
    // }
    loadingWidget();
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
  }

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
    log('loan update response $parsedData');
    if (parsedData['status'] == true) {
      log(parsedData.toString());
      getLoanDocuments();
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
