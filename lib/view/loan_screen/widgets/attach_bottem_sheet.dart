import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';
import 'package:rtd_project/core/common_widget/imagepicker.dart';

class AttachBottemSheet extends StatelessWidget {
  const AttachBottemSheet({super.key});

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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Upload Documents",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
                "Small description about what kind of documents are needed can be shown here.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  minRadius: 35.r,
                  backgroundColor: textFormBase,
                  backgroundImage:
                      AssetImage('assets/images/pexels-pixabay-220453 1.png'),
                ),
                CircleAvatar(
                  minRadius: 35.r,
                  backgroundColor: textFormBase,
                  child: IconButton(
                      onPressed: () {
                        // showModalBottomSheet(
                        //   context: context,
                        //   builder: (context) => Imagepiker(),
                        // );
                      },
                      icon: Icon(Icons.add)),
                ),
                CircleAvatar(
                  minRadius: 35.r,
                  backgroundColor: textFormBase,
                  child: IconButton(
                      onPressed: () {
                        // showModalBottomSheet(
                        //   context: context,
                        //   builder: (context) => Imagepiker(),
                        // );
                      },
                      icon: Icon(Icons.add)),
                ),
              ],
            ),
            ButtonWidget(
                press: () {
                  Navigator.pop(context);
                },
                buttonBackgroundColor: buttenBlue,
                buttonForegroundColor: whiteColor,
                buttonText: 'Submit',
                borderAvalable: true),
          ],
        ),
      ),
    );
  }
}
