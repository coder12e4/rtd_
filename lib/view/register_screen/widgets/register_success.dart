import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/helper/router.dart';

import '../../../core/color/colors.dart';
import '../../../core/common_widget/commen_botten.dart';

class RegisterComplited extends StatelessWidget {
  const RegisterComplited({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.h,
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
          Image.asset(
            'assets/images/Happy 1.png',
            height: 150.h,
          ),
          SizedBox(
              width: 290.w,
              child: const Text(
                'Your membership registration is currently being processed.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              )),
          SizedBox(
            height: 10.h,
          ),
          const Text(
            'We\'ll get back to you soon.',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30.h,
          ),
          ButtonWidget(
              press: () {
                Get.offAllNamed(AppRouter.getInitialRoute());
              },
              buttonBackgroundColor: buttenBlue,
              buttonForegroundColor: whiteColor,
              buttonText: 'Continue!',
              borderAvalable: true)
        ],
      ),
    );
  }
}
