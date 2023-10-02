import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/controller/loan/loan_screen_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';

class CancelPopup extends StatelessWidget {
  const CancelPopup({super.key, required this.controller, required this.index});
  final LoanScreenController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: 400.w,
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(50),
          topStart: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Do you really want to cancel the loan request?',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            ),
            ButtonWidget(
                buttonBackgroundColor: buttenBlue,
                buttonForegroundColor: whiteColor,
                buttonText: "Yes",
                borderAvalable: false,
                press: () {
                  controller.cancelLoanRequest(controller.loanData[index].id);
                  Navigator.pop(context);
                }),
            ButtonWidget(
                buttonBackgroundColor: whiteColor,
                buttonForegroundColor: buttenBlue,
                buttonText: "No",
                borderAvalable: true,
                press: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
