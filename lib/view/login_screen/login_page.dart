import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/view/register_screen/register_screen.dart';

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
              height: 390.h,
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
                    height: 40.h,
                  ),
                  TextFormFieldWidget(
                      controller: emailController, hitText: 'Username'),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormFieldWidget(
                      controller: passwordController, hitText: 'Password'),
                  SizedBox(
                    height: 20.h,
                  ),
                  ButtonWidget(
                    press: () {},
                    borderAvalable: false,
                    buttonText: 'Login',
                    buttonBackgroundColor: buttenBlue,
                    buttonForegroundColor: whiteColor,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  forgotButton(),
                  SizedBox(
                    height: 20.h,
                  ),
                  notAmembertext(),
                  SizedBox(
                    height: 15.h,
                  ),
                  ButtonWidget(
                    press: () {
                      Get.to(RegisterScreen(), transition: Transition.downToUp);
                    },
                    borderAvalable: true,
                    buttonText: 'Register',
                    buttonBackgroundColor: whiteColor,
                    buttonForegroundColor: buttenBlue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Text notAmembertext() {
    return const Text(
      'Not a Member?',
      style: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w900),
    );
  }

  TextButton forgotButton() {
    return TextButton(
      onPressed: () {},
      style: const ButtonStyle(),
      child: const Text(
        'Forgot Password?',
        style: TextStyle(
          color: buttenBlue,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
    );
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

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    super.key,
    required this.buttonBackgroundColor,
    required this.buttonForegroundColor,
    required this.buttonText,
    required this.borderAvalable,
    required this.press,
  });

  final Color buttonBackgroundColor;
  final Color buttonForegroundColor;
  final String buttonText;
  bool borderAvalable = false;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 32.h,
        width: 260.w,
        child: ElevatedButton(
            style: borderAvalable
                ? ButtonStyle(
                    foregroundColor:
                        MaterialStatePropertyAll(buttonForegroundColor),
                    backgroundColor:
                        MaterialStatePropertyAll(buttonBackgroundColor))
                : ButtonStyle(
                    foregroundColor:
                        MaterialStatePropertyAll(buttonForegroundColor),
                    backgroundColor:
                        MaterialStatePropertyAll(buttonBackgroundColor)),
            onPressed: press,
            child: Text(buttonText)));
  }
}
