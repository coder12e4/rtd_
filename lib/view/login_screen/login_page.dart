import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';

import '../../core/common_widget/textformfield_widget.dart';

class LOginPage extends StatelessWidget {
  const LOginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: baseColor,
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            welcomeWidget(context),
            nochBarAboveLoginContainer(),
            SizedBox(
              height: 5.h,
            ),
            Container(
              height: 400.h,
              width: 390.w,
              decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(50),
                      topStart: Radius.circular(50))),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  TextFormFieldWidget(
                      controller: emailController, hitText: 'Email'),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Container nochBarAboveLoginContainer() {
    return Container(
      height: 5.h,
      width: 100.w,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20)),
    );
  }

  Center welcomeWidget(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 150.h, bottom: 70.h),
        child: Text(
          'Welcome',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
