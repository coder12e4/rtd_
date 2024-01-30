import 'dart:developer';

import 'package:get/get.dart';
import 'package:rtd_project/util/toast.dart';

import '../../backend/model/loan/loan_request_details.dart';
import '../../backend/parser/loan/loan_request_details_parser.dart';
import '../../helper/router.dart';

class LoanRequestDetailsController extends GetxController
    implements GetxService {
  final LoanRequestDetailsParser parser;
  LoanRequestDetailsController({required this.parser});
  @override
  void onInit() {
    id = Get.arguments[0].toString();
    backNavigation = Get.arguments[2];
    if (Get.arguments[1] == true) {
      getLoanRequestDetails();
    } else {
      getLoanRequestDetailsForSurety();
    }

    super.onInit();
  }

  int? backNavigation;
  String? id;
  bool error = false;
  bool loading = true;
  LoanRequestDetails? loanRequestDetails;
  Future<void> getLoanRequestDetails() async {
    final body = {"loan_request_id": id};
    Response response = await parser.getLoanRequestDetails(body);
    log("loan request details response ${response.body} ");
    try {
      if (response.statusCode == 200) {
        if (response.body["status"] == true) {
          loanRequestDetails = LoanRequestDetails.fromJson(response.body);
          loading = false;
        } else {
          error = true;
          showToast(response.body["message"].toString());
        }
      } else {
        error = true;
      }
    } catch (e, stackTrace) {
      log('loan request details catch $e', error: e, stackTrace: stackTrace);
    }

    update();
  }

  void backRout() {
    log('navigation num $backNavigation');
    if (backNavigation == 1) {
      Get.offAllNamed(AppRouter.getNotificationPageRoute());
    }
    if (backNavigation == 2) {
      Get.back();
    }
  }

  Future<void> getLoanRequestDetailsForSurety() async {
    final body = {"loan_request_id": id};

    Response response = await parser.getLoanRequestDetailsForSurety(body);
    log("loan request for surety details response ${response.body} ");
    try {
      if (response.statusCode == 200) {
        if (response.body["status"] == true) {
          loanRequestDetails = LoanRequestDetails.fromJson(response.body);
          loading = false;
        } else {
          error = true;
          showToast(response.body["message"].toString());
        }
      } else {
        error = true;
      }
    } catch (e, stackTrace) {
      log('loan request for surety details catch $e',
          error: e, stackTrace: stackTrace);
    }

    update();
  }
}
