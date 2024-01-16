import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtd_project/util/toast.dart';

import '../../backend/model/notification_model/notification_model.dart';
import '../../backend/model/poll_details_model.dart';
import '../../backend/parser/notification/notification_parser.dart';
import 'notification_controller.dart';

class SuretyViewController extends GetxController implements GetxService {
  final NotificationParser parser;
  SuretyViewController({required this.parser});
  @override
  void onInit() {
    voteId = Get.arguments[0].toString();
    details = Get.arguments[1];
    isPoll = Get.arguments[2];
    if (isPoll != null && isPoll == true) {
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

  NotificationDetails? details;
  bool? isPoll;
  bool? isSelected = false;
  final TextEditingController reasonController = TextEditingController();

  void onChanged(int? newValue) {
    groupValue = newValue;
    isSelected = !isSelected!;
    log(groupValue.toString());
    update();
  }

  void onSubmit() {
    if (groupValue == 0) {
      showToast('Select an option');
      return;
    }
    if (groupValue == 1) {
      acceptSurety();
    } else if (groupValue == 2) {
      rejectSurety();
    }
    Get.find<NotificationController>().getNotification();
  }

  Future<void> getPollDetails() async {
    final body = {"question_id": voteId};
    Response response = await parser.getPollDetails(body);
    log('poll details response ${response.body}');
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

  Future<void> acceptSurety() async {
    final body = {"loan_request_id": details?.details?.id};
    Response response = await parser.suretyAccept(body);
    log('surety accept response ${response.body}');
    Get.back();
    if (response.statusCode == 200) {
      try {
        successToast(response.body["message"]);
      } catch (e, stackTrace) {
        log('surety accept catch $e', error: e, stackTrace: stackTrace);
      }
    }
    update();
  }

  Future<void> rejectSurety() async {
    final body = {
      "loan_request_id": details?.details?.id,
      "reject_reason": reasonController.text,
    };
    Response response = await parser.suretyReject(body);
    log('surety accept response ${response.body}');
    Get.back();
    if (response.statusCode == 200) {
      try {
        successToast(response.body["message"]);
      } catch (e, stackTrace) {
        log('surety accept catch $e', error: e, stackTrace: stackTrace);
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
