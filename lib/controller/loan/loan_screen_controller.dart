import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/core/constraints/api_urls.dart';
import 'package:rtd_project/util/loading_widget.dart';

import '../../backend/model/loan/loan_purpose.dart';
import '../../backend/model/loan/loan_request_model.dart';
import '../../backend/model/loan/loan_type_model.dart';
import '../../backend/model/loan/surties_model.dart';
import '../../backend/parser/loan/loan_screen_parser.dart';
import '../../helper/router.dart';
import '../../util/toast.dart';

class LoanScreenController extends GetxController {
  final LoanScreenParser parser;
  LoanScreenController({required this.parser});
  @override
  Future<void> onInit() async {
    Future.wait([
      getLoanType(),
      getLoanRequestData(),
    ]);

    super.onInit();
  }

  bool loading = true;
  var loanId;
  Data? loan;
  bool isAccepted = false;

  String? loanAmount;
  PurposeData? purposeData;
  bool image1 = false;
  XFile? selectedImage1;
  XFile? selectedImage2;
  XFile? selectedImage3;
  LoanPurposeData? loanPurpose;
  int suretyCount = 0;
  bool isCompleted = false;
  List<int> noOfSurties = [];
  TextEditingController loanAmountController = TextEditingController();
  final List<LoanData> _loanData = <LoanData>[];
  List<LoanData> get loanData => _loanData;
  List<SuretiesData?> surties = <SuretiesData?>[];
  final List<int> _addedSurties = <int>[];
  List<int> get addedSurties => _addedSurties;
  List<Data> _getLoanTypes = <Data>[];
  List<Data> get getLoanTypes => _getLoanTypes;
  final List<PurposeData> _getPurposeType = <PurposeData>[];
  List<PurposeData> get getPurposeType => _getPurposeType;
  final List<PurposeData> _getPurpose = <PurposeData>[];
  List<PurposeData> get getPurpose => _getPurpose;
  List<DropdownMenuItem<Data>> _dropdownMenuLoanType =
      <DropdownMenuItem<Data>>[];
  List<DropdownMenuItem<Data>> get dropdownMenuLoanType =>
      _dropdownMenuLoanType;

  List<DropdownMenuItem<PurposeData>> _dropdownMenuPurpose =
      <DropdownMenuItem<PurposeData>>[];
  List<DropdownMenuItem<PurposeData>> get dropdownMenuPurpose =>
      _dropdownMenuPurpose;

  List<bool> isSelected = [false, false, false];
  LoanType? loanType;
  String? purpose;
  void toggleSelection() {
    isAccepted = !isAccepted;
    update();
  }

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

  Future<void> selectPurpose(id) async {
    final body = {
      "loan_type": 1,
    };
    Response response = await parser.getLoanPurpose(body);
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

  void updateLoanAmount(amount) {
    loanAmount = amount;
    update();
  }

  Future<void> getLoanPurpose(id) async {
    loadingWidget();
    purpose = null;
    purposeData = null;
    final body = {"loan_type": id};
    Response response = await parser.getLoanPurpose(body);
    if (response.statusCode == 200) {
      log('Loan purpose responce :${response.body}');
      try {
        loanPurpose = LoanPurposeData.fromJson(response.body);

        _addedSurties.clear();
        surties.clear();
        isSelected.clear();
        noOfSurties.clear();
        suretyCount = 0;
        for (int i = 1; i <= loanPurpose!.data[0].noOfSureties; i++) {
          noOfSurties.add(1);
          // _addedSurties.add(-1);
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
        Get.back();
        update();
        // log(_getPurposeType.toString());
        // log('loan purpose surety : $noOfSurties');
        // log('loan amount : $loanAmount');
      } catch (e, stackTrace) {
        log('loanPurpose catch $e', error: e, stackTrace: stackTrace);
      }
    }
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
      } catch (e, stackTrace) {
        log('Loan request data error $e', error: e, stackTrace: stackTrace);
      }
    }
    loading = false;
    update();
  }

  void updateLoanSuretyCount(PurposeData purposeData) {
    _addedSurties.clear();
    surties.clear();
    isSelected.clear();
    noOfSurties.clear();
    for (int i = 1; i <= purposeData.noOfSureties; i++) {
      noOfSurties.add(1);
      // _addedSurties.add(-1);
      surties.add(null);
      isSelected.add(false);
    }
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
                fontSize: 15,
                letterSpacing: .1,
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    return items;
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
                fontSize: 15,
                letterSpacing: .1,
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    return items;
  }

  void deleteSurety(int index, id) {
    suretyCount--;
    log("surety count $suretyCount ");
    addedSurties.remove(id);
    surties[index] = null;
    isSelected[index] = !isSelected[index];

    // if (noOfSurties.length < 5) {
    //   addedSurties.removeLast();
    //   surties.removeLast();
    //   isSelected.removeLast();
    // }
    // noOfSurties.removeLast();
    update();
  }

  void addSurties(SuretiesData surety, int index) {
    if (addedSurties.contains(surety.id)) {
      showToast('Surety already selected');
      return;
    }
    if (!addedSurties.contains(surety.id)) {
      suretyCount++;
      isSelected[index] = !isSelected[index];
      addedSurties.add(surety.id);
      surties[index] = surety;

      log(addedSurties.toString());
      log('selected surty$surties');
      Get.back();
      successToast('Surety selected');
    }
    update();
  }

  Future<void> uploadLoanDocument(XFile? data, loanId) async {
    // Get.back();

    loadingWidget();
    var uri = Uri.parse(Constants.baseUrl + Constants.uploadLoanDocument);
    var request = http.MultipartRequest("POST", uri);
    String? accessToken =
        parser.sharedPreferencesManager.getString('access_token');

    if (data != null) {
      var file = await http.MultipartFile.fromPath('loan_document', data.path);
      request.files.add(file);
    } else {
      showToast('Select a image to upload');
    }

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
    log("document upload data $parsedData");
    Get.back();
    if (parsedData['status'] == true) {
      log(parsedData.toString());
      Get.back();
      successToast('Document uploaded');
    } else {
      showToast(parsedData['message']);
    }
    update();
  }

  Future<void> upload() async {
    if (loan == null) {
      showToast('Select loan type');
      return;
    }
    if (purposeData == null) {
      showToast('Loan purpose not selected');
      return;
    }
    if (!isAccepted) {
      showToast('Please Agree the Rules and Instructions to continue.');
      return;
      // value.getLoanRequestData();
    }
    log('added sureties$addedSurties');

    loadingWidget();
    var uri =
        Uri.parse("http://rtd.canisostudio.com/api/user/loan/request/create");
    var request = http.MultipartRequest("POST", uri);
    // var file1 =
    //     await http.MultipartFile.fromPath('loan_document', data1?.path ?? '');
    // request.files.add(file1);
    log('loan amount@@@@@@@@@@ $loanAmount');
    String? accessToken =
        parser.sharedPreferencesManager.getString('access_token');

    request.fields['sureties'] = addedSurties.toString();
    request.fields['loan_purpose'] = loanPurpose!.data[0].id.toString();
    request.fields['loan_amount'] = loanAmount!;
    request.fields['loan_type'] = loan!.id.toString();

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
    log("loan create response $parsedData");
    if (parsedData['status'] == true) {
      Get.back();
      suretyCount = 0;
      addedSurties.clear();
      surties.clear();
      isSelected.clear();
      noOfSurties.clear();

      loanAmountController.clear();
      loanId = parsedData['data']['id'];
      // successToast(parsedData['message'].toString());
      // showModalBottomSheet(
      //   context: context,
      //   isDismissible: false,
      //   builder: (context) => LoanDocumentsBottomSheet(
      //     press: () {
      //       // Get.back();
      //       successToast('Loan Request created');
      //       selectedImage1 = null;
      //       selectedImage2 = null;
      //       selectedImage3 = null;
      //
      //       Get.offAllNamed(AppRouter.getBottomNavRoute(), arguments: [2]);
      //     },
      //     loanId: parsedData['data']['id'],
      //   ),
      // );
      if (loan!.id == 1) {
        loanRequestComplete();
      } else {
        isCompleted = true;
      }
      update();
      // getLoanRequestData();
    } else {
      Get.back();
      // String errorMessage = '';
      // for (var error in parsedData['errors']) {
      //   errorMessage = "${errorMessage + error['error_name']}\n ";
      //   log(errorMessage.toString());
      //   // error += error;
      // }

      showToast(parsedData['message'].toString());
    }
  }

  Future<void> loanRequestComplete() async {
    loadingWidget();
    final body = {
      "loan_request_id": loanId,
    };
    Response response = await parser.loanRequestComplete(body);
    Get.back();
    try {
      if (response.statusCode == 200) {
        if (response.body["status"] == true) {
          successToast(response.body["message"].toString());
          selectedImage1 = null;
          selectedImage2 = null;
          selectedImage3 = null;

          Get.offAllNamed(AppRouter.getBottomNavRoute(), arguments: [2]);
          getLoanRequestData();
        } else {
          showToast(response.body["message"].toString());
        }
      } else {
        showToast(response.body["message"].toString());
      }
    } catch (e, stackTrace) {
      log('loan request complete catch $e', error: e, stackTrace: stackTrace);
    }
  }

  void updateSelectedImage1(XFile? newImage) {
    selectedImage1 = newImage;
    image1 = true;
    update();
  }

  void updateSelectedImage2(XFile? newImage) {
    selectedImage2 = newImage;
    image1 = true;
    update();
  }

  void updateSelectedImage3(XFile? newImage) {
    selectedImage3 = newImage;
    image1 = true;
    update();
  }
}
