import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../backend/model/loan/loan_type_model.dart';
import '../../../controller/loan/loan_screen_controller.dart';
import '../../../core/color/colors.dart';
import '../../../core/common_widget/commen_botten.dart';
import '../../../core/constraints/conatrints.dart';
import '../../../helper/router.dart';
import '../../../util/theme.dart';
import 'loan_request_rule_button.dart';
import 'porpose.dart';

class NewRequestView extends StatefulWidget {
  const NewRequestView({super.key, required this.value});
  final LoanScreenController value;

  @override
  State<NewRequestView> createState() => _NewRequestViewState();
}

class _NewRequestViewState extends State<NewRequestView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 50.h,
            width: 290.w,
            decoration: BoxDecoration(
              color: textFormBase,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20).r,
                child: DropdownButton<Data>(
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    letterSpacing: .1,
                  ),
                  isExpanded: true,
                  underline: const Offstage(),
                  hint: const Center(
                    child: Text(
                      "Select Loan Type",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  value: widget.value.loan,
                  // Set the initial value (hint text)
                  onChanged: (newValue) {
                    setState(() {});
                    widget.value.loan = newValue;
                    widget.value.purpose = newValue?.title ?? "";

                    widget.value.getLoanPurpose(newValue?.id);
                    log(widget.value.loan!.id.toString());
                  },
                  items: widget.value.dropdownMenuLoanType,
                ),
              ),
            ),
          ),
          kSizedBoxH,
          PorposeWidget(value: widget.value),
          kSizedBoxH,
          const Align(
              alignment: Alignment.centerLeft, child: Text('Choose Sureties')),
          kSizedBoxH,
          SizedBox(
            height: 80.h,
            child: widget.value.noOfSurties.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.value.noOfSurties.length,
                    itemBuilder: (context, index) => widget
                                .value.isSelected[index] ==
                            false
                        ? GestureDetector(
                            onTap: () => Get.toNamed(
                                AppRouter.getSearchScreenRoute(),
                                arguments: [index, false]),
                            child: CircleAvatar(
                              minRadius: 35.r,
                              backgroundColor: textFormBase,
                              child: const Icon(Icons.add),
                            ),
                          )
                        : Container(
                            width: 80.h,
                            height: 80.h,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      minRadius: 35.r,
                                      backgroundColor: textFormBase,
                                      backgroundImage:
                                          CachedNetworkImageProvider(widget
                                              .value
                                              .surties[index]!
                                              .profileImage),
                                    ),
                                    Positioned(
                                      bottom: 9.h,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () => widget.value.deleteSurety(
                                            index,
                                            widget.value.surties[index]!.id),
                                        child: CircleAvatar(
                                          minRadius: 15.r,
                                          backgroundColor:
                                              ThemeProvider.blackColor,
                                          child: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text("${widget.value.surties[index]!.name}" ??
                                    "")
                              ],
                            ),
                          ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 15,
                    ),
                  )
                : const Center(
                    child: Text(
                      'Select loan type to choose surety',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 50.h,
            width: 290.w,
            decoration: BoxDecoration(
              color: textFormBase,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                widget.value.loanAmount ?? 'Loan Amount',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          kSizedBoxH,
          LoanRulesButton(controller: widget.value),
          kSizedBoxH,
          ButtonWidget(
            buttonBackgroundColor: buttenBlue,
            buttonForegroundColor: whiteColor,
            buttonText: 'submit',
            borderAvalable: false,
            press: () {
              widget.value.upload();
            },
          )
        ],
      ),
    );
  }
}
