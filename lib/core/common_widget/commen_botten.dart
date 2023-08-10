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
  });

  final buttonBackgroundColor;
  final buttonForegroundColor;
  final buttonText;
  final bool borderAvalable;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 32.h,
        width: 290.w,
        child: ElevatedButton(
            style: ButtonStyle(
                side: borderAvalable
                    ? MaterialStatePropertyAll(BorderSide(color: buttenBlue))
                    : null,
                foregroundColor:
                    MaterialStatePropertyAll(buttonForegroundColor),
                backgroundColor:
                    MaterialStatePropertyAll(buttonBackgroundColor)),
            onPressed: () {},
            child: Text(buttonText)));
  }
}
