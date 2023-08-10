import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';

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
            style: ButtonStyle(
                side: borderAvalable
                    ? MaterialStatePropertyAll(BorderSide(color: buttenBlue))
                    : null,
                foregroundColor:
                    MaterialStatePropertyAll(buttonForegroundColor),
                backgroundColor:
                    MaterialStatePropertyAll(buttonBackgroundColor)),
            onPressed: press,
            child: Text(buttonText)));
  }
}
