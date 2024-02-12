import 'dart:developer';

import 'package:get/get.dart';

import '../../backend/model/loan/active_loan_model.dart';
import '../../backend/parser/loan/loan_details_parser.dart';

class LoanDetailsController extends GetxController {
  final LoanDetailsParser parser;
  LoanDetailsController({required this.parser});
  @override
  Future<void> onInit() async {
    Future.wait([
      getActiveLoan(),
      getClosedLoan(),
    ]);

    super.onInit();
  }

  ActiveLoans? activeLoans;
  ActiveLoans? closedLoans;

  Future<void> getActiveLoan() async {
    Response response = await parser.getActiveLoan();
    log("Active loan list ${response.body}");
    if (response.statusCode == 200) {
      try {
        // Map<String, dynamic> data = Map<String, dynamic>.from(response.body);
        activeLoans = ActiveLoans.fromJson(response.body);
        log(activeLoans!.data.data.toString());
      } catch (e, stackTrace) {
        log("Active loan catch $e", error: e, stackTrace: stackTrace);
      }
    }

    update();
  }

  Future<void> getClosedLoan() async {
    Response response = await parser.getClosedLoan();
    log("Closed loan list ${response.body}");
    if (response.statusCode == 200) {
      try {
        // Map<String, dynamic> data = Map<String, dynamic>.from(response.body);
        closedLoans = ActiveLoans.fromJson(response.body);
        log(closedLoans!.data.data.toString());
      } catch (e, stackTrace) {
        log("Closed loan catch $e", error: e, stackTrace: stackTrace);
      }
    }

    update();
  }
}
