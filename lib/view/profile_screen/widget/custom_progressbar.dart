import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/loan/profile_loan_data_controller.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    super.key,
    required this.value,
  });
  final ProfileLoanDataController value;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        LinearProgressIndicator(
          minHeight: 30.h,
          borderRadius: BorderRadius.circular(20).r,
          value: value.progressValue,
          backgroundColor: const Color.fromARGB(255, 207, 200, 200),
          valueColor: const AlwaysStoppedAnimation<Color>(
            Color.fromARGB(255, 147, 8, 96),
          ),
        ),
        Text(
          'Due in ${value.remainingDays} days',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
