import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/loan/loan_screen_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';
import 'package:rtd_project/core/common_widget/imagepicker.dart';

class LoanDocumentsBottomSheet extends StatefulWidget {
  const LoanDocumentsBottomSheet({
    super.key,
    required this.press,
    this.loanId,
  });
  // final String sizeText;

  final Function() press;
  final loanId;
  @override
  State<LoanDocumentsBottomSheet> createState() =>
      _LoanDocumentsBottomSheetState();
}

class _LoanDocumentsBottomSheetState extends State<LoanDocumentsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoanScreenController>(builder: (value) {
      return Container(
        height: 240.h,
        width: 390.w,
        decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(50),
            topStart: Radius.circular(50),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            const Text(
              "Upload Documents",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  value.selectedImage1 == null
                      ? selectionContainer(
                          onImageSelected: value.updateSelectedImage1,
                          onPress: () {
                            // Get.back();
                            value.uploadLoanDocument(
                                value.selectedImage1, widget.loanId);
                          },
                        )
                      : Image.file(
                          File(value.selectedImage1?.path ?? ''),
                          height: 50.h,
                          width: 50.w,
                        ),
                  value.selectedImage2 == null
                      ? selectionContainer(
                          onPress: () {
                            value.uploadLoanDocument(
                                value.selectedImage2, widget.loanId);
                            // Get.back();
                          },
                          onImageSelected: value.updateSelectedImage2,
                        )
                      : Image.file(
                          File(value.selectedImage2?.path ?? ''),
                          height: 50.h,
                          width: 50.w,
                        ),
                  value.selectedImage3 == null
                      ? selectionContainer(
                          onPress: () {
                            value.uploadLoanDocument(
                                value.selectedImage3, widget.loanId);
                            // Get.back();
                          },
                          onImageSelected: value.updateSelectedImage3,
                        )
                      : Image.file(
                          File(value.selectedImage3?.path ?? ''),
                          height: 50.h,
                          width: 50.w,
                        ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            value.selectedImage1 != null &&
                    value.selectedImage2 != null &&
                    value.selectedImage3 != null
                ? ButtonWidget(
                    press: widget.press,
                    buttonBackgroundColor: buttenBlue,
                    buttonForegroundColor: whiteColor,
                    buttonText: 'submit',
                    borderAvalable: true)
                : ButtonWidget(
                    press: () {},
                    buttonBackgroundColor: Colors.grey,
                    buttonForegroundColor: whiteColor,
                    buttonText: 'submit',
                    borderAvalable: false),
          ],
        ),
      );
    });
    // },
    // );
  }

  GestureDetector selectionContainer(
      {required Function() onPress, required onImageSelected}) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) => Imagepiker(
          press: onPress,
          onImageSelected: onImageSelected,
        ),
      ),
      child: Container(
        width: 80.w,
        height: 80.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xfff3f3f3),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
    );
  }
}
