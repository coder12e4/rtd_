import 'dart:developer';

import 'package:get/get.dart';
import 'package:rtd_project/util/toast.dart';

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
  bool error = false;
  LoanData? loanData;
  // final startDate = DateTime(2024, 01, 01); // Replace with your start date
  final startDate = DateTime(2024, 01, 01); // Replace with your start date
  final endDate = DateTime(2024, 01, 15); // Replace with your end date
  final now = DateTime.now();

  double get progressValue {
    final totalDuration = endDate.difference(startDate).inMilliseconds;
    final elapsedDuration = now.difference(startDate).inMilliseconds;
    log('balance days ${now.difference(endDate).inDays}.');
    return elapsedDuration / totalDuration;
  }

  Future<void> getLoanDetails() async {
    final body = {"loan_id": loanId};
    Response response = await parser.getLoanDetails(body);
    log('loan details ${response.body}');
    if (response.statusCode == 200) {
      if (response.body["status"] == true) {
        try {
          loanData = LoanData.fromJson(response.body);
        } catch (e, stackTrace) {
          log(e.toString(), error: e, stackTrace: stackTrace);
        }
      } else {
        error = true;
        showToast(response.body["message"]);
      }
    }
    loading = false;

    update();
  }
}
