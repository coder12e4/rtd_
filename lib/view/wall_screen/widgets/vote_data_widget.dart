import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/common_widget/dotted_text.dart';

import '../../../controller/wall_screen_controller.dart';
import '../../../core/color/colors.dart';
import '../../../core/constraints/conatrints.dart';
import '../../../util/toast.dart';

class VoteDataWidget extends StatelessWidget {
  const VoteDataWidget(
      {super.key, required this.controller, required this.index});
  final WallScreenController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, left: 18.w, right: 18.w),
      child: Container(
        // height: 300.h,
        // width: 500.w,
        decoration: BoxDecoration(
            color: textFormBase,
            borderRadius: BorderRadius.all(Radius.circular(30.r))),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    height: 40.h,
                    width: 160.w,
                    child: Center(
                      child: Text(
                        'Pole Number: ${controller.votesData[index].id}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 100.w,
                    decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: Text(
                        controller.votesData[index].activeStatus == true
                            ? 'Active'
                            : 'Closed',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              kSizedBoxH,
              Text(controller.votesData[index].title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
              kSizedBoxH,
              const DashText(),
              kSizedBoxH,
              Wrap(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 15.w,
                runSpacing: 15.h,
                children: controller.votesData[index].options
                    .map(
                      (i) => GestureDetector(
                        onTap: () {
                          // controller.selectedOption = i.option;
                          // controller.update();
                          if (controller.votesData[index].activeStatus) {
                            controller.selectOption(i.option, index);
                            controller.optionId = i.id;
                          } else {
                            showToast("Time Expired");
                          }
                        },
                        child: optionButton(
                            borderAvalable:
                                controller.selectedOption[index] == i.option
                                    ? true
                                    : false,
                            buttonForegroundColor: Colors.white,
                            buttonbackgroundColor: Colors.black,
                            buttonText: i.option),
                      ),
                    )
                    .toList(),
              ),
              kSizedBoxH20,
              Align(
                alignment: Alignment.center,
                child: controller.votesData[index].activeStatus == true
                    ? submitedButton(
                        submitStatus: controller.votesData[index].isVoted,
                        activeStatus: controller.votesData[index].activeStatus,
                        buttonForegroundColor: whiteColor,
                        buttonbackgroundColor: Colors.blue,
                        press: () {
                          controller
                              .submitVote(
                                  controller.votesData[index].options[0]
                                      .voteQuestionId,
                                  controller.optionId!)
                              .then((value) => controller.optionId = null);
                        },
                      )
                    : submitedButton(
                        // submitStatus: controller.votesData[index].isVoted,
                        activeStatus: controller.votesData[index].activeStatus,
                        buttonForegroundColor: whiteColor,
                        buttonbackgroundColor: Colors.black,
                        press: () {},
                      ),
              ),
              kSizedBoxH20,
            ],
          ),
        ),
      ),
    );
  }
}

SizedBox submitedButton({
  bool? submitStatus,
  required bool activeStatus,
  Color? buttonForegroundColor,
  Color? buttonbackgroundColor,
  Function()? press,
}) {
  return SizedBox(
    height: 30.h,
    width: 260.w,
    child: ElevatedButton(
      style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(buttonForegroundColor),
          backgroundColor: MaterialStatePropertyAll(
              submitStatus != true ? buttonbackgroundColor : Colors.grey)),
      onPressed: submitStatus != true ? press : null,
      child: activeStatus
          ? Text(
              submitStatus != true ? 'Submit' : "submited",
              style: const TextStyle(fontWeight: FontWeight.w700),
            )
          : const Text(
              "Time Expired",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
    ),
  );
}

SizedBox optionButton(
    {bool? borderAvalable,
    Color? buttonForegroundColor,
    Color? buttonbackgroundColor,
    Function()? press,
    String? buttonText}) {
  return SizedBox(
      height: 40.h,
      // width: 260.w,
      child: ElevatedButton(
          style: ButtonStyle(
              side: borderAvalable == false
                  ? const MaterialStatePropertyAll(
                      BorderSide(color: Colors.black))
                  : null,
              foregroundColor: MaterialStatePropertyAll(borderAvalable == true
                  ? buttonForegroundColor
                  : buttonbackgroundColor),
              backgroundColor: MaterialStatePropertyAll(borderAvalable == true
                  ? buttonbackgroundColor
                  : buttonForegroundColor)),
          onPressed: press,
          child: Text(
            buttonText!,
            style: const TextStyle(fontWeight: FontWeight.w700),
          )));
}
