import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rtd_project/controller/loan/loan_edit_controller.dart';
import 'package:rtd_project/controller/loan/loan_request_detail_controller.dart';
import 'package:rtd_project/controller/loan/loan_screen_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:rtd_project/view/loan_screen/widgets/cancel_popup.dart';
import 'package:rtd_project/view/loan_screen/widgets/porpose.dart';

import '../../backend/model/loan/loan_type_model.dart';
import '../../controller/loan/loan_rules.dart';
import '../../core/common_widget/loane_documents.dart';
import '../../helper/router.dart';
import '../../util/toast.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  @override
  void initState() {
    Get.find<LoanScreenController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<LoanScreenController>(builder: (value) {
        return Scaffold(
          backgroundColor: baseColor,
          body: DefaultTabController(
            length: 2,
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kSizedBoxH,
                wallTextWidget(context),
                kSizedBoxH,
                tabBar(),
                tabBarView(context, value),
              ],
            ),
          ),
          bottomSheet: value.isCompleted == true
              ? LoanDocumentsBottomSheet(
                  loanId: value.loanId,
                  press: () => value.loanRequestComplete(),
                )
              : const Offstage(),
        );
      }),
    );
  }

  Container requestDate(String date) {
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
    return Container(
      height: 30.h,
      width: 120.w,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: textFormBase),
      child: Center(
        child: Text(formattedDate, textAlign: TextAlign.center),
      ),
    );
  }

  Widget tabBarView(BuildContext context, LoanScreenController value) {
    return value.loading == true
        ? Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(40),
                  topStart: Radius.circular(40),
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 6,
                ),
              ),
            ),
          )
        : Expanded(
            child: Container(
              //hallo
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(40),
                  topStart: Radius.circular(40),
                ),
              ),
              child: TabBarView(children: [
                newRequestView(context, value),
                requestView(context, value),
              ]),
            ),
          );
  }

  Padding requestView(BuildContext context, LoanScreenController value) {
    return Padding(
      padding: EdgeInsets.only(top: 2.5.h),
      child: value.loanData.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.only(bottom: 10.h),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: value.loanData.length,
              itemBuilder: (context, index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  kSizedBoxH,
                  requestDate(value.loanData[index].createdAt.toString()),
                  kSizedBoxH,
                  requestData(context, value, index)
                ],
              ),
            )
          : const Center(
              child: Text(
                'No request Found',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ),
    );
  }

  Padding requestData(
      BuildContext context, LoanScreenController value, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GestureDetector(
        onTap: () {
          Get.delete<LoanRequestDetailsController>(force: true);
          Get.toNamed(AppRouter.getLoanRequestDetailsRoutes(),
              arguments: [value.loanData[index].id, true]);
        },
        child: Container(
          // height: prossesing == true ? 300.h : 360.h,
          height: 300.h,
          width: 500.w,
          decoration: BoxDecoration(
              color: textFormBase,
              borderRadius: BorderRadius.all(Radius.circular(30.r))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    loanStatusContainer(value, index),
                    value.loanData[index].status == 0
                        ? GestureDetector(
                            onTap: () {
                              Get.delete<LoanEditController>(force: true);
                              Get.toNamed(AppRouter.getLoanEditRoute(),
                                  arguments: [value.loanData[index].id]);
                            },
                            child: Container(
                              height: 40.h,
                              width: 110.w,
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: const Center(
                                child: Text(
                                  'Edit Request',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 50.w,
                          )
                  ],
                ),
                const Divider(),
                loanAmount(
                    price: value.loanData[index].loanAmount,
                    title: 'ആവശ്യപ്പെട്ടത്:'),
                const Divider(),
                imageRow(value, index),
                SizedBox(
                  height: 8.h,
                ),
                value.loanData[index].status != 1 &&
                        value.loanData[index].status != 2
                    ? ButtonWidget(
                        buttonBackgroundColor: value.loanData[index].status != 3
                            ? whiteColor
                            : Colors.grey,
                        buttonForegroundColor: value.loanData[index].status != 3
                            ? buttenBlue
                            : whiteColor,
                        buttonText: value.loanData[index].status != 3
                            ? 'Cancel Request'
                            : 'cancelled',
                        borderAvalable:
                            value.loanData[index].status == 0 ? true : false,
                        controller: value,
                        press: () {
                          value.loanData[index].status != 3
                              ? showModalBottomSheet(
                                  context: context,
                                  builder: (context) => CancelPopup(
                                    controller: value,
                                    index: index,
                                  ),
                                )
                              : null;
                        })
                    : const Offstage(),
                // : Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         'Reasons for rejection:',
                //         style: TextStyle(
                //             color: Colors.black54,
                //             fontWeight: FontWeight.w600),
                //       ),
                //       SizedBox(
                //         height: 8.h,
                //       ),
                //       const Text(
                //         'Here reasons for the rejection can be shown',
                //         style: TextStyle(
                //             color: Colors.black, fontWeight: FontWeight.w600),
                //       ),
                //       const Text(
                //         ' \ . First reason for rejection',
                //         style: TextStyle(
                //             color: Colors.black, fontWeight: FontWeight.w600),
                //       ),
                //       const Text(
                //         ' \. Second reason for rejection',
                //         style: TextStyle(
                //             color: Colors.black, fontWeight: FontWeight.w600),
                //       ),
                //       const Text(
                //         ' \. Third reason for rejection',
                //         style: TextStyle(
                //             color: Colors.black, fontWeight: FontWeight.w600),
                //       )
                //     ],
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container loanStatusContainer(LoanScreenController value, int index) {
    if (value.loanData[index].status == 3) {
      return Container(
        decoration: const BoxDecoration(
            color: ThemeProvider.blackColor,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        height: 40.h,
        width: 150.w,
        child: Center(
          child: Text(
            'Status:  ${value.loanData[index].statusText}',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: ThemeProvider.whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    if (value.loanData[index].status == 1) {
      return Container(
        decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        height: 40.h,
        width: 150.w,
        child: Center(
          child: Text(
            'Status:  ${value.loanData[index].statusText}',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: ThemeProvider.whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    if (value.loanData[index].status == 2) {
      return Container(
        decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        height: 40.h,
        width: 150.w,
        child: Center(
          child: Text(
            'Status:  ${value.loanData[index].statusText}',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: ThemeProvider.whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    return Container(
      decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      height: 40.h,
      width: 150.w,
      child: Center(
        child: Text(
          'Status:  ${value.loanData[index].statusText}',
          textAlign: TextAlign.center,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget imageRow(LoanScreenController controller, int index) {
    return SizedBox(
      height: 60.h,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, imageIndex) =>
              checkMarkImage(controller, index, imageIndex),
          separatorBuilder: (context, index) => SizedBox(
                width: 15.w,
              ),
          itemCount: controller.loanData[index].sureties.length),
    );
  }

  Stack checkMarkImage(
      LoanScreenController controller, int index, int imageIndex) {
    return Stack(
      children: [
        CircleAvatar(
          minRadius: 30.r,
          backgroundImage: CachedNetworkImageProvider(
              controller.loanData[index].sureties[imageIndex].profileImage),
        ),
        Positioned(
          bottom: 4.h,
          right: 0,
          child: surtieStatus(controller, index, imageIndex),
        )
      ],
    );
  }

  Container surtieStatus(
      LoanScreenController controller, int index, int imageIndex) {
    if (controller.loanData[index].sureties[imageIndex].status == 0) {
      return Container(
        width: 20.w,
        height: 18.h,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(50.r))),
        child: const Icon(
          Icons.pending_actions,
          color: Colors.white,
          size: 16,
        ),
      );
    }
    if (controller.loanData[index].sureties[imageIndex].status == 1) {
      return Container(
        width: 20.w,
        height: 18.h,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(50.r))),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 16,
        ),
      );
    }

    return Container(
      width: 20.w,
      height: 18.h,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(50.r))),
      child: const Icon(
        Icons.close,
        color: Colors.white,
        size: 16,
      ),
    );
  }

  Padding loanAmount({String? title, String? price}) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.money),
              Text(
                title!,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ],
          ),
          Text(
            '$price INR',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
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

  Padding newRequestView(BuildContext context, LoanScreenController value) {
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
                  isExpanded: true,
                  underline: Container(),
                  hint: Center(
                    child: Text(
                      "Select Loan Type",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black.withOpacity(.55),
                          fontSize: 17,
                          letterSpacing: .1,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  value: value.loan,
                  // Set the initial value (hint text)
                  onChanged: (newValue) {
                    setState(() {});
                    value.loan = newValue;
                    value.purpose = newValue!.title;

                    value.getLoanPurpose(newValue.id);
                    log(value.loan!.id.toString());
                  },
                  items: value.dropdownMenuLoanType,
                ),
              ),
            ),
          ),
          kSizedBoxH,
          PorposeWidget(value: value),
          kSizedBoxH,
          const Align(
              alignment: Alignment.centerLeft, child: Text('Choose Sureties')),
          kSizedBoxH,
          SizedBox(
            height: 80.h,
            child: value.noOfSurties.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: value.noOfSurties.length,
                    itemBuilder: (context, index) => value.isSelected[index] ==
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
                        : Stack(
                            children: [
                              Hero(
                                tag: value.surties[index]!.id.toString(),
                                child: CircleAvatar(
                                  minRadius: 35.r,
                                  backgroundColor: textFormBase,
                                  backgroundImage: CachedNetworkImageProvider(
                                      value.surties[index]!.profileImage),
                                ),
                              ),
                              Positioned(
                                bottom: 9.h,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () => value.deleteSurety(
                                      index, value.surties[index]!.id),
                                  child: CircleAvatar(
                                    minRadius: 15.r,
                                    backgroundColor: ThemeProvider.blackColor,
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
                value.loanAmount ?? 'Loan Amount',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          LoanRulesButton(controller: value),
          kSizedBoxH,
          ButtonWidget(
            buttonBackgroundColor: buttenBlue,
            buttonForegroundColor: whiteColor,
            buttonText: 'submit',
            borderAvalable: false,
            press: () {
              if (value.isAccepted) {
                value.upload(value.loan?.id ?? '', value.addedSurties, context);
                value.getLoanRequestData();
              } else {
                showToast(
                    'Please Agree the Rules and Instructions to continue.');
              }
            },
          )
        ],
      ),
    );
  }

  // Container feedDate(String date) {
  //   return Container(
  //     height: 30.h,
  //     width: 120.w,
  //     decoration: const BoxDecoration(
  //         borderRadius: BorderRadius.all(Radius.circular(30)),
  //         color: textFormBase),
  //     child: Center(
  //       child: Text(date, textAlign: TextAlign.center),
  //     ),
  //   );
  // }

  Padding tabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorColor: Colors.blue,
          automaticIndicatorColorAdjustment: true,
          indicatorWeight: 4.0,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              height: 20.h,
              text: 'New Request',
            ),
            Tab(
              height: 20.h,
              text: 'Request',
            )
          ]),
    );
  }

  Text wallTextWidget(BuildContext context) {
    return Text(
      'Loan Request',
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
    );
  }
}

class LoanRulesButton extends StatelessWidget {
  const LoanRulesButton({
    super.key,
    required this.controller,
  });
  final LoanScreenController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          toggleable: true,
          value: 'accepted',
          groupValue: controller.isAccepted ? "accepted" : "not",
          onChanged: (value) {
            controller.toggleSelection();
          },
        ),
        SizedBox(width: 2.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'I have read and agreed to the',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              // Adjust the text styling as needed
            ),
            InkWell(
              onTap: () {
                Get.to(
                  const LoanRules(),
                );
              },
              child: const Text(
                'Rules & Instructions for loan.',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: buttenBlue),
                // Adjust the text styling as needed
              ),
            ),
          ],
        ),
      ],
    );
  }
}
