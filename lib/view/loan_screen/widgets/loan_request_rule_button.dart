import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/loan/loan_rules.dart';
import '../../../controller/loan/loan_screen_controller.dart';
import '../../../core/color/colors.dart';

class LoanRulesButton extends StatelessWidget {
  const LoanRulesButton({
    super.key,
    required this.controller,
  });
  final LoanScreenController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          toggleable: true,
          value: 'accepted',
          groupValue: controller.isAccepted ? "accepted" : "not",
          onChanged: (value) {
            controller.toggleSelection();
          },
        ),
        SizedBox(width: 2.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'I have read and agreed to the',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              // Adjust the text styling as needed
            ),
            InkWell(
              onTap: () {
                Get.to(
                  const LoanRules(),
                );
              },
              child: const Text(
                'Rules & Instructions for loan.',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: buttenBlue),
                // Adjust the text styling as needed
              ),
            ),
          ],
        ),
      ],
    );
  }
}
