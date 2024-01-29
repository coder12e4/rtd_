import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/authentication/login_contoller.dart';
import 'package:rtd_project/controller/authentication/regitration.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/util/validators.dart';

import '../../core/common_widget/textformfield_widget.dart';
import '../../helper/router.dart';

class LOginPage extends StatelessWidget {
  const LOginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    FocusNode node = FocusNode();

    return SafeArea(
        child: Scaffold(
      backgroundColor: baseColor,
      body: SingleChildScrollView(
        child: GetBuilder<LoginController>(
          builder: (value) {
            return Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                welcomeWidget(context),
                SizedBox(
                  height: 45.h,
                ),
                nochBarAboveLoginContainer(),
                SizedBox(
                  height: 5.h,
                ),
                Form(
                  key: formKey,
                  child: Container(
                    height: 350.h,
                    width: 390.w,
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(50),
                        topStart: Radius.circular(50),
                      ),
                    ),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        TextFormFieldWidget(
                            validator: Rtd_Validators.noneEmptyValidator,
                            controller: value.mobileNumberController,
                            textInputType: TextInputType.phone,
                            hitText: 'Registered Mobile Number'),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: 290.w,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              focusNode: node,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: Rtd_Validators.passwordValidator,
                              controller: value.passwordController,
                              obscureText: value.passwordVisible,
                              decoration: InputDecoration(
                                  border:
                                      InputBorder.none, // Removes the underline

                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      value.passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      value.visibiltyValueChange();
                                    },
                                  ),
                                  hintText: "Password",
                                  fillColor: textFormBase,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: textFormBase),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: textFormBase),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: textFormBase),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: textFormBase),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(255, 112, 111, 111),
                                      fontWeight: FontWeight.bold)),
                              textAlign: TextAlign
                                  .center, // Centers the text inside the field
                            ),
                          ),
                        ),
                        kSizedBoxH20,
                        ButtonWidget(
                          press: () {
                            if (formKey.currentState!.validate()) {
                              value.onLogin();
                            }
                          },
                          borderAvalable: false,
                          buttonText: 'Login',
                          buttonBackgroundColor: buttenBlue,
                          buttonForegroundColor: whiteColor,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        // forgotButton(),
                        // SizedBox(
                        //   height: 10.h,
                        // ),

                        Center(child: notAmembertext()),
                        SizedBox(
                          height: 10.h,
                        ),
                        ButtonWidget(
                          press: () {
                            Get.delete<RegisterController>(force: true);
                            Get.toNamed(AppRouter.getSignUpRoute());
                          },
                          borderAvalable: true,
                          buttonText: 'Register',
                          buttonBackgroundColor: whiteColor,
                          buttonForegroundColor: buttenBlue,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
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

// ignore: must_be_immutable
