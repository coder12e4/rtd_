import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/notification/surety_view_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';
import 'package:rtd_project/core/common_widget/textformfield_widget.dart';
import 'package:rtd_project/util/validators.dart';

class NotificationViewScreen extends StatelessWidget {
  const NotificationViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: baseColor,
        body: SingleChildScrollView(
          child: GetBuilder<SuretyViewController>(builder: (value) {
            return Column(
              children: [
                appbar(context),
                Container(
                  height: 920.h,
                  width: 390.w,
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(50),
                        topEnd: Radius.circular(50),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 30.0.w, right: 30.w, top: 25.h),
                              child: Text(
                                "${value.details?.message}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),

                            radioButton(
                              controller: value,
                              text: 'Accept Request',
                              value: 1,
                            ),
                            Divider(
                              indent: 35.w,
                              endIndent: 35.w,
                            ),
                            // RadioButtonWidgetNotification(
                            //   text: 'Reject Request',
                            //   controller: value,
                            //   value: 2,
                            // ),
                            radioButton(
                              controller: value,
                              text: 'Reject Request',
                              value: 2,
                            ),
                            Divider(
                              indent: 35.w,
                              endIndent: 35.w,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 38.0.w),
                              child: const Text(
                                'Share Reasons for rejection',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 117, 113, 113)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 38.0.w, vertical: 9.h),
                              child: TextFormFieldWidget(
                                validator: Rtd_Validators.noneEmptyValidator,
                                controller: value.reasonController,
                                hitText: "Type your reason here",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 9.h, left: 48.w),
                              child: ButtonWidget(
                                  buttonBackgroundColor:
                                      const Color.fromARGB(255, 4, 78, 139),
                                  buttonForegroundColor: whiteColor,
                                  buttonText: 'Submit',
                                  borderAvalable: true,
                                  press: () {
                                    value.onSubmit();
                                  }),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 50.h,
                      // ),
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Container appbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: whiteColor,
                size: 30,
              )),
          SizedBox(
            width: 90.w,
          ),
          Text(
            'Notification',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Padding radioButton(
      {required int value,
      required SuretyViewController controller,
      required String text}) {
    return Padding(
      padding: EdgeInsets.only(
        left: 18.0.w,
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio<int>(
            // The actual Radio widget
            value: value,
            groupValue:
                controller.groupValue, // Use groupValue based on _isSelected
            onChanged: controller.onChanged,
          ),
          const SizedBox(width: 5),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                // Adjust the text styling as needed
              ),
            ],
          ),
        ],
      ),
    );
  }
}
