import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';

class LoginComplited extends StatelessWidget {
  const LoginComplited({super.key});

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
                Navigator.pop(context);
              },
              buttonBackgroundColor: buttenBlue,
              buttonForegroundColor: whiteColor,
              buttonText: 'Wait!',
              borderAvalable: true)
        ],
      ),
    );
  }
}
