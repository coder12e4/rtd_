import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';

class Imagepiker extends StatelessWidget {
  const Imagepiker({super.key});

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
          SizedBox(
            height: 30.h,
          ),
          Text(
            "Upload your ID Proof",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 116,
                height: 121,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    color: Color(0xfff3f3f3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/gallary.png'),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text("Choose from Gallery",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ))
                  ],
                ),
              ),
              Container(
                width: 116,
                height: 121,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    color: Color(0xfff3f3f3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/camara.png'),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text("Capture from Camera",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Text("No file Selected",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
          SizedBox(
            height: 20.h,
          ),
          ButtonWidget(
              buttonBackgroundColor: buttenBlue,
              buttonForegroundColor: whiteColor,
              buttonText: 'Upload',
              borderAvalable: true)
        ],
      ),
    );
  }
}
