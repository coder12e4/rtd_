import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtd_project/util/toast.dart';

import '../../backend/model/poll_details_model.dart';
import '../../backend/parser/notification/notification_parser.dart';

class SuretyViewController extends GetxController implements GetxService {
  final NotificationParser parser;
  SuretyViewController({required this.parser});
  @override
  void onInit() {
    voteId = Get.arguments[0].toString();
    if (voteId != null) {
      getPollDetails();
    }
    super.onInit();
  }

  bool voteLoading = true;
  String selectedOption = '';
  var voteId;
  int? optionId;
  PollDetails? pollDetails;
  int? groupValue = 0;
  bool? isSelected = false;
  final TextEditingController reasonController = TextEditingController();

  void onChanged(int? newValue) {
    groupValue = newValue;
    isSelected = !isSelected!;
    print(groupValue);
    update();
  }

  void onSubmit() {
    if (groupValue == 0) {
      showToast('Select an option');
      return;
    }
    if (groupValue == 1) {
      // parser.suretyAccept(body);
    } else if (groupValue == 2) {
      // parser.suretyReject(body);
    }
  }

  Future<void> getPollDetails() async {
    final body = {"question_id": voteId};
    Response response = await parser.getPollDetails(body);
    if (response.statusCode == 200) {
      try {
        log(response.body.toString());
        pollDetails = PollDetails.fromJson(response.body);
        voteLoading = false;
      } catch (e, stackTrace) {
        log('poll details catch $e', error: e, stackTrace: stackTrace);
      }
    }
    update();
  }

  Future<void> submitVote(int questionId, int optionId) async {
    final body = {
      "question_id": questionId,
      "option_id": optionId,
    };
    Response response = await parser.submitVote(body);
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonData =
            Map<String, dynamic>.from(response.body);
        if (jsonData['status'] == true) {
          successToast(jsonData['message']);
          selectedOption = '';
          getPollDetails();
        } else {
          showToast(jsonData['message']);
        }
        log(response.body.toString());
      } catch (e) {
        log('votes submit $e');
      }

      update();
    }
  }

  void selectOption(String option) {
    selectedOption = option;
    update();
  }
}
