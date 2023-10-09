import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtd_project/util/toast.dart';

import '../../backend/parser/notification/notification_parser.dart';

class SuretyViewController extends GetxController implements GetxService {
  final NotificationParser parser;
  SuretyViewController({required this.parser});

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
}
