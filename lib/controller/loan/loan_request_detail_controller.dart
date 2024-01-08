import 'dart:developer';

import 'package:get/get.dart';

import '../../backend/model/loan/loan_request_details.dart';
import '../../backend/parser/loan/loan_request_details_parser.dart';

class LoanRequestDetailsController extends GetxController
    implements GetxService {
  final LoanRequestDetailsParser parser;
  LoanRequestDetailsController({required this.parser});
  @override
  void onInit() {
    id = Get.arguments[0].toString();
    getLoanRequestDetails();
    super.onInit();
  }

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
        loanRequestDetails = LoanRequestDetails.fromJson(response.body);
        loading = false;
      } else {
        error = true;
      }
    } catch (e, stackTrace) {
      log('loan request details catch $e', error: e, stackTrace: stackTrace);
    }

    update();
  }
}
