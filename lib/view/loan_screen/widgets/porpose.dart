import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/backend/model/loan/loan_purpose.dart';
import 'package:rtd_project/core/color/colors.dart';

import '../../../controller/loan/loan_screen_controller.dart';

class PorposeWidget extends StatefulWidget {
  const PorposeWidget({super.key, required this.value});
  final LoanScreenController value;
  @override
  State<PorposeWidget> createState() => _PorposeWidgetState();
}

class _PorposeWidgetState extends State<PorposeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 290.w,
      decoration: BoxDecoration(
        color: textFormBase,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20).r,
          child: DropdownButton<PurposeData>(
            isExpanded: true,
            underline: Container(),
            hint: Center(
              child: Text(
                "Select Purpose",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(.55),
                    fontSize: 17,
                    letterSpacing: .1,
                    fontWeight: FontWeight.w600),
              ),
            ),
            value: widget.value.purposeData,

            // Set the initial value (hint text)
            onChanged: (newValue) {
              setState(() {});
              widget.value.purposeData = newValue;
              widget.value.purpose = newValue!.purpose;
              // widget.value.getLoanPurpose(newValue.id);
              log(widget.value.purposeData!.id.toString());
            },
            items: widget.value.dropdownMenuPurpose,
          ),
        ),
      ),
    );
  }
}
