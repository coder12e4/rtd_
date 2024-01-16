import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/util/theme.dart';

import '../../../controller/notification/surety_view_controller.dart';
import '../../../core/color/colors.dart';
import '../../../core/common_widget/commen_botten.dart';

class VoteViewScreen extends StatelessWidget {
  const VoteViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: baseColor,
        body: GetBuilder<SuretyViewController>(builder: (value) {
          final data = value.pollDetails?.data;
          return Column(
            children: [
              appbar(context),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(50),
                        topEnd: Radius.circular(50),
                      )),
                  child: value.voteLoading != true
                      ? Column(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.h, left: 18.w, right: 18.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: textFormBase,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.r))),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.w, right: 20.w, top: 20.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: whiteColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                                  height: 40.h,
                                                  width: 160.w,
                                                  child: Center(
                                                    child: Text(
                                                      'Pole Number: ${data!.id}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 40.h,
                                                  width: 100.w,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: whiteColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                                  child: Center(
                                                    child: Text(
                                                      data.activeStatus == true
                                                          ? 'Active'
                                                          : 'Closed',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            kSizedBoxH,
                                            Text(data.title,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16)),
                                            divider(),
                                            Wrap(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              spacing: 15.w,
                                              runSpacing: 15.h,
                                              children: data.options
                                                  .map(
                                                    (i) => GestureDetector(
                                                      onTap: () {
                                                        // controller.selectedOption = i.option;
                                                        // controller.update();
                                                        value.selectOption(
                                                          i.option,
                                                        );
                                                        value.optionId = i.id;
                                                      },
                                                      child: optionButton(
                                                          borderAvalable:
                                                              value.selectedOption ==
                                                                      i.option
                                                                  ? true
                                                                  : false,
                                                          buttonForegroundColor:
                                                              Colors.white,
                                                          buttonbackgroundColor:
                                                              Colors.black,
                                                          buttonText: i.option),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                            kSizedBoxH20,
                                            Align(
                                              alignment: Alignment.center,
                                              child: ButtonWidget(
                                                buttonBackgroundColor:
                                                    data.isVoted != true
                                                        ? const Color.fromARGB(
                                                            255, 4, 78, 139)
                                                        : Colors.grey,
                                                buttonForegroundColor:
                                                    whiteColor,
                                                buttonText: data.isVoted != true
                                                    ? 'Submit'
                                                    : 'Voted',
                                                borderAvalable:
                                                    data.isVoted != true
                                                        ? true
                                                        : false,
                                                press: () {
                                                  data.isVoted != true
                                                      ? value.submitVote(
                                                          data.id,
                                                          value.optionId!)
                                                      : null;
                                                },
                                              ),
                                            ),
                                            kSizedBoxH20,
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 50.h,
                            // ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 6,
                            color: ThemeProvider.blackColor,
                          ),
                        ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  SizedBox divider() {
    return SizedBox(
      width: 270.w,
      child: const Text(
        '-------------------',
        style: TextStyle(fontSize: 30),
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
}
