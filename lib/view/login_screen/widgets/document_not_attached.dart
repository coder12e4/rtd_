import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';

import '../../../controller/authentication/regitration.dart';
import '../../../helper/router.dart';

class RegisterDocPending extends StatelessWidget {
  const RegisterDocPending({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: 390.w,
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(50),
          topStart: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.pending_actions,
            size: 50,
          ),
          kSizedBoxH20,
          Container(
              width: 290.w,
              child: const Text(
                'Your membership registration is not completed.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              )),
          SizedBox(
            height: 10.h,
          ),
          const Text(
            'Please attach necessary documents.',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30.h,
          ),
          ButtonWidget(
              press: () {
                Get.back();
                Get.delete<RegisterController>(force: true);
                Get.toNamed(AppRouter.getSignUpRoute());
              },
              buttonBackgroundColor: buttenBlue,
              buttonForegroundColor: whiteColor,
              buttonText: 'Complete',
              borderAvalable: true)
        ],
      ),
    );
  }
}
