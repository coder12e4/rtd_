import 'dart:developer';

import 'package:get/get.dart';

import '../../backend/model/loan/profile_loan_data_model.dart';
import '../../backend/parser/loan/loan_details_parser.dart';

class ProfileLoanDataController extends GetxController {
  final LoanDetailsParser parser;

  ProfileLoanDataController({required this.parser});
  @override
  void onInit() {
    loanId = Get.arguments[0];
    getLoanDetails();
    super.onInit();
  }

  var loanId;
  bool loading = true;
  LoanData? loanData;
  Future<void> getLoanDetails() async {
    final body = {"loan_id": loanId};
    Response response = await parser.getLoanDetails(body);
    if (response.statusCode == 200) {
      try {
        loanData = LoanData.fromJson(response.body);
      } catch (e, stackTrace) {
        log(e.toString(), error: e, stackTrace: stackTrace);
      }
    }
    loading = false;
    update();
    log(response.body.toString());
  }
}
